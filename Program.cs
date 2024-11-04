using System;
using System.Runtime.InteropServices;
using Gtk;
using System.Text;

namespace GLIFortranGUI{
        public class MainWindow : Window
    {
        public MainWindow() : base("Formulario de Datos Sísmicos")
        {
            SetDefaultSize(600, 600);
            SetPosition(WindowPosition.Center);

            HBox hboxMain = new HBox(false, 10); // Contenedor horizontal para las dos columnas
            VBox vboxLeft = new VBox(false, 5);  // Columna izquierda
            VBox vboxRight = new VBox(false, 5); // Columna derecha

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

            // Añadir las columnas al contenedor horizontal
            hboxMain.PackStart(vboxLeft, true, true, 10);
            hboxMain.PackStart(vboxRight, true, true, 10);

            // Crear un VBox para el formulario completo, incluyendo el botón
            VBox vboxMain = new VBox(false, 10);
            vboxMain.PackStart(hboxMain, true, true, 0);

            // Botón de envío
            Button submitButton = new Button("Enviar");
            submitButton.Clicked += (sender, e) =>
            {
                // Aquí podrías procesar los datos ingresados
                Console.WriteLine("Datos enviados");
            };
            vboxMain.PackStart(submitButton, false, false, 10);

            // Añadir el contenedor principal al formulario
            Add(vboxMain);

            DeleteEvent += delegate { Application.Quit(); };
            ShowAll();
        }

        private HBox CreateEntry(string placeholder)
        {
            HBox hbox = new HBox(false, 5);
            Label label = new Label(placeholder);
            Entry entry = new Entry();
            
            hbox.PackStart(label, false, false, 0);
            hbox.PackStart(entry, true, true, 0);
            
            return hbox;
        }

        public static void Main()
        {
            Application.Init();
            new MainWindow();
            Application.Run();
        }
    }
}
