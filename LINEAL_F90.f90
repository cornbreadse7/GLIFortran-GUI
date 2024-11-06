PROGRAM LINEAL
! Analisis lineal de sistemas con torsión

IMPLICIT NONE
                                      ! Nombre archivo datos del sistema
INTEGER :: N,NAX,NAY,TMOD,TEXC        ! Grados de libertad, registros y tipo de modelo
INTEGER :: FREX,FREY                  ! Factores reducción fuerza sísmica
INTEGER(4) :: COUNT                   ! Contador
INTEGER(2) :: STATUS
REAL :: B,A                           ! Dimensiones planta
REAL :: EXC                           ! Relación de excentricidad
REAL :: W                             ! Peso por nivel
REAL :: Z,FI                          ! Factores zona sísmica (0.15,0.2,0.3,0.4) e importancia (1.25,1)
REAL :: S,CT                          ! Coeficiente de sitio (1,1.2,1.5,2) y de periodo
REAL :: HI                            ! Altura entrepiso
REAL :: DT                            ! Incremento de tiempo
REAL, DIMENSION(5,10) ::  DY          ! Desplazamiento en la fluencia
REAL, DIMENSION(30,30) :: MASA,RISI   ! Matrices de masa y rigidez del sistema
REAL, DIMENSION(30,30) :: MA          ! Matriz de amortiguamiento
REAL, DIMENSION(30) :: P              ! Aceleraciones en X e Y
REAL, DIMENSION(1000) :: ACEX,ACEY    ! Aceleraciones sísmicas

! Llama a la subrutina para leer los datos del sistema desde un archivo
CALL LECDAT(N,TMOD,TEXC,B,A,W,Z,FI,S,CT,HI,EXC,FREX,FREY,DT,NAX,NAY,ACEX,ACEY)

! Escribir información básica del sistema
WRITE(*,10) N
WRITE(*,20) B,A
WRITE(*,30) TMOD,TEXC
WRITE(*,40) EXC

! Leer matriz de masa y rigidez, y calcular frecuencias
CALL MATMAS(N,B,A,W,MASA)
CALL MATRIG(N,TEXC,B,A,W,Z,FI,S,CT,HI,EXC,FREX,FREY,MASA,RISI,P)
CALL FRECUENCIAS(N,MASA,RISI,MA)

WRITE(*,*) "MODELO ESTATICO COMPLETO"
WRITE(*,*)   ! Pausa antes de continuar

! Solución del sistema
WRITE(*,*) "SOLUCION DEL SISTEMA"
CALL SOLUELA(RISI,N,P)

! Finalización
WRITE(*,*) "Programa terminado"

10 FORMAT('Grados de libertad del sistema:', I3)
20 FORMAT('Dimensiones planta tipo:', 2F6.2)
30 FORMAT('Modelo, Tipo Excentricidad', 2I3)
40 FORMAT('Relación de excentricidad', F6.2)

END PROGRAM LINEAL

SUBROUTINE LECDAT(N, TMOD, TEXC, B, A, W, Z, FI, S, CT, HI, EXC, FREX, FREY, DTX, NAX, NAY, ACX, ACY)
    ! OBJETIVO: Lectura de datos del sistema desde un archivo
    IMPLICIT NONE
    ! Variables de la subrutina
    SAVE
    INTEGER, INTENT(OUT) :: N              ! Grados de libertad del sistema
    INTEGER, INTENT(OUT) :: TMOD, TEXC     ! Tipo de modelo y excentricidad
    REAL, INTENT(OUT) :: B, A              ! Dimensiones planta tipo
    REAL, INTENT(OUT) :: W                 ! Peso por nivel
    REAL, DIMENSION(1000), INTENT(OUT) :: ACX, ACY      ! Arreglo de aceleraciones
    INTEGER, INTENT(OUT) :: NAX, NAY       ! Número de registros en X e Y
    INTEGER :: FREX, FREY, NP              ! Factores de reducción y número de pisos
    REAL :: RASP, EXC                      ! Relación de aspecto y excentricidad
    REAL :: HI, WUS                        ! Altura de entrepiso y peso por unidad de superficie
    REAL :: Z, FI                          ! Factor de zona sísmica y de importancia
    REAL :: S, CT                          ! Coeficiente de sitio y para el periodo
    REAL :: FEX, FEY                       ! Factores de escala en X e Y
    REAL :: DTX, DTY                       ! Incrementos de tiempo
    INTEGER :: I
    CHARACTER(LEN=100) :: FILENAME
    CHARACTER(LEN=100) :: LINE
    INTEGER :: UNIT

    ! Abrir el archivo de datos
    FILENAME = 'datos_sismicos.txt'
    OPEN(UNIT=10, FILE=FILENAME, STATUS='OLD', ACTION='READ')

    ! Leer los datos del archivo
    READ(10,*) TMOD, TEXC
    READ(10,*) NP, FREX, FREY
    READ(10,*) RASP, B, EXC, HI, WUS
    READ(10,*) Z, FI, S, CT
    READ(10,*) NAX, FEX, DTX
    IF (NAX > 0) THEN
        DO I = 1, NAX
            READ(10,*) ACX(I)
            ACX(I) = ACX(I) * FEX
        END DO
    END IF
    READ(10,*) NAY, FEY, DTY
    IF (NAY > 0) THEN
        DO I = 1, NAY
            READ(10,*) ACY(I)
            ACY(I) = ACY(I) * FEY
        END DO
    END IF

    ! Cálculos finales
    N = 3 * NP
    A = B / RASP
    W = A * B * WUS

    CLOSE(10)

    WRITE(*,*) 'GRADOS DE LIBERTAD=', N
    WRITE(*,*) 'ANCHO=', A
    WRITE(*,*) 'PESO=', W
END SUBROUTINE