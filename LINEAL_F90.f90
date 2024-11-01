
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


! Llama a la subrutina para leer los datos del sistema
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
