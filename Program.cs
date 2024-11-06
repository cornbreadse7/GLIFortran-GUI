using System;
using System.Runtime.InteropServices;
using Gtk;
using System.IO;

public class MainWindow : Window
{
    [DllImport("liblecdat.so", CallingConvention = CallingConvention.Cdecl)]
    public static extern void LECDAT(
        out int N, out int TMOD, out int TEXC, out float B, out float A, out float W,
        out float Z, out float FI, out float S, out float CT, out float HI, out float EXC,
        out int FREX, out int FREY, out float DTX, out int NAX, out int NAY,
        [Out] float[] ACX, [Out] float[] ACY);

    private TextView textViewContent;

    public MainWindow() : base("Formulario de Datos Sísmicos")
    {
        SetDefaultSize(600, 700);
        SetPosition(WindowPosition.Center);

        HBox hboxMain = new HBox(false, 10);
        VBox vboxLeft = new VBox(false, 5);
        VBox vboxRight = new VBox(false, 5);

        // Agregar campos a la columna izquierda
        vboxLeft.PackStart(CreateEntry("Ingrese el identificador del sistema (IDEN):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese TMOD (Tipo de modelo):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese TEXC (Tipo de excentricidad):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese NP (Número de pisos):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese FREX (Factores de reducción en X):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese FREY (Factores de reducción en Y):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese RASP (Relación de aspecto):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese B (Lado mayor de la planta):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese EXC (Excentricidad):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese HI (Altura entrepiso):"), false, false, 0);
        vboxLeft.PackStart(CreateEntry("Ingrese WUS (Peso por m2):"), false, false, 0);

        // Agregar campos a la columna derecha
        vboxRight.PackStart(CreateEntry("Ingrese Z (Factor de zona sísmica):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese FI (Factor de importancia):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese S (Coef de sitio):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese CT (Coef para el periodo):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese NAX (Número de registros en X):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese el factor de escala FEX:"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese DTX (Incremento de tiempo en X):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese los valores de aceleraciones en X (ACX):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese NAY (Número de registros en Y):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese el factor de escala FEY:"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese DTY (Incremento de tiempo en Y):"), false, false, 0);
        vboxRight.PackStart(CreateEntry("Ingrese los valores de aceleraciones en Y (ACY):"), false, false, 0);

        hboxMain.PackStart(vboxLeft, true, true, 10);
        hboxMain.PackStart(vboxRight, true, true, 10);

        VBox vboxMain = new VBox(false, 10);
        vboxMain.PackStart(hboxMain, true, true, 0);

        // Botón para abrir archivo .txt
        Button openFileButton = new Button("Abrir archivo .txt");
        openFileButton.Clicked += OnOpenFileButtonClicked;
        vboxMain.PackStart(openFileButton, false, false, 10);

        // TextView para mostrar el contenido del archivo
        textViewContent = new TextView();
        textViewContent.Editable = false;
        ScrolledWindow scrolledWindow = new ScrolledWindow();
        scrolledWindow.Add(textViewContent);
        scrolledWindow.SetSizeRequest(580, 200);
        vboxMain.PackStart(scrolledWindow, true, true, 10);

        // Botón de envío
        Button submitButton = new Button("Enviar");
        submitButton.Clicked += OnSubmitButtonClicked;
        vboxMain.PackStart(submitButton, false, false, 10);

        Add(vboxMain);

        DeleteEvent += delegate { Application.Quit(); };
        ShowAll();
    }

    private HBox CreateEntry(string placeholder)
    {
        HBox hbox = new HBox(false, 5);
        Label label = new Label(placeholder);
        Entry entry = new Entry();
        entry.Name = placeholder; // Set the name to identify the entry later
        
        hbox.PackStart(label, false, false, 0);
        hbox.PackStart(entry, true, true, 0);
        
        return hbox;
    }

    private void OnOpenFileButtonClicked(object sender, EventArgs e)
    {
        FileChooserDialog fileChooser = new FileChooserDialog(
            "Seleccione un archivo .txt",
            this,
            FileChooserAction.Open,
            "Cancelar", ResponseType.Cancel,
            "Abrir", ResponseType.Accept
        );

        FileFilter filter = new FileFilter();
        filter.Name = "Archivos de texto";
        filter.AddPattern("*.txt");
        filter.AddPattern("*.TXT");
        filter.AddPattern("*.csv");
        filter.AddPattern("*.CSV");
        filter.AddPattern("*.dat");
        filter.AddPattern("*.DAT");
        fileChooser.AddFilter(filter);

        if (fileChooser.Run() == (int)ResponseType.Accept)
        {
            string filePath = fileChooser.Filename;
            string fileContent = File.ReadAllText(filePath);
            textViewContent.Buffer.Text = fileContent;
        }

        fileChooser.Destroy();
    }

    private void OnSubmitButtonClicked(object sender, EventArgs e)
    {
        int N, TMOD, TEXC, FREX, FREY, NAX, NAY;
        float B, A, W, Z, FI, S, CT, HI, EXC, DTX;
        float[] ACX = new float[1000];
        float[] ACY = new float[1000];

        // Aquí se deben obtener los valores de los campos de entrada
        // Por ejemplo:
        TMOD = int.Parse(GetEntryText("Ingrese TMOD (Tipo de modelo):"));
        TEXC = int.Parse(GetEntryText("Ingrese TEXC (Tipo de excentricidad):"));
        // ... (obtener el resto de los valores de la misma manera)

        // Llamar a la subrutina Fortran
        LECDAT(out N, out TMOD, out TEXC, out B, out A, out W, out Z, out FI, out S, out CT, out HI, out EXC, out FREX, out FREY, out DTX, out NAX, out NAY, ACX, ACY);

        Console.WriteLine("Datos enviados a Fortran");
    }

    private string GetEntryText(string placeholder)
    {
        foreach (Widget widget in ((VBox)((HBox)Child).Children[0]).Children)
        {
            if (widget is HBox hbox)
            {
                foreach (Widget innerWidget in hbox.Children)
                {
                    if (innerWidget is Entry entry && entry.Name == placeholder)
                    {
                        return entry.Text;
                    }
                }
            }
        }

        foreach (Widget widget in ((VBox)((HBox)Child).Children[1]).Children)
        {
            if (widget is HBox hbox)
            {
                foreach (Widget innerWidget in hbox.Children)
                {
                    if (innerWidget is Entry entry && entry.Name == placeholder)
                    {
                        return entry.Text;
                    }
                }
            }
        }

        return string.Empty;
    }

    public static void Main()
    {
        Application.Init();
        new MainWindow();
        Application.Run();
    }
}