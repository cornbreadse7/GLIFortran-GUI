! FILE: LECDAT.F90
SUBROUTINE LECDAT(N, TMOD, TEXC, B, A, W, Z, FI, S, CT, HI, EXC, FREX, FREY, DTX, NAX, NAY, ACX, ACY) BIND(C, NAME="LECDAT")
    USE ISO_C_BINDING
    IMPLICIT NONE
    INTEGER(C_INT), INTENT(OUT) :: N              ! Grados de libertad del sistema
    INTEGER(C_INT), INTENT(OUT) :: TMOD, TEXC     ! Tipo de modelo y excentricidad
    REAL(C_FLOAT), INTENT(OUT) :: B, A            ! Dimensiones planta tipo
    REAL(C_FLOAT), INTENT(OUT) :: W               ! Peso por nivel
    REAL(C_FLOAT), DIMENSION(1000), INTENT(OUT) :: ACX, ACY  ! Arreglo de aceleraciones
    INTEGER(C_INT), INTENT(OUT) :: NAX, NAY       ! Número de registros en X e Y
    INTEGER(C_INT) :: FREX, FREY, NP              ! Factores de reducción y número de pisos
    REAL(C_FLOAT) :: RASP, EXC                    ! Relación de aspecto y excentricidad
    REAL(C_FLOAT) :: HI, WUS                      ! Altura de entrepiso y peso por unidad de superficie
    REAL(C_FLOAT) :: Z, FI                        ! Factor de zona sísmica y de importancia
    REAL(C_FLOAT) :: S, CT                        ! Coeficiente de sitio y para el periodo
    REAL(C_FLOAT) :: FEX, FEY                     ! Factores de escala en X e Y
    REAL(C_FLOAT) :: DTX, DTY                     ! Incrementos de tiempo
    INTEGER(C_INT) :: I

    ! Aquí se deben asignar los valores recibidos desde C#
    ! Por ejemplo:
    N = 3 * NP
    A = B / RASP
    W = A * B * WUS

    ! Cálculos finales
    WRITE(*,*) 'GRADOS DE LIBERTAD=', N
    WRITE(*,*) 'ANCHO=', A
    WRITE(*,*) 'PESO=', W
END SUBROUTINE