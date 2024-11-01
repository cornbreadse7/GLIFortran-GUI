SUBROUTINE LECDAT(N, TMOD, TEXC, B, A, W, Z, FI, S, CT, HI, EXC, FREX, FREY, DTX, NAX, NAY, ACX, ACY)
    ! OBJETIVO: Lectura de datos del sistema desde la entrada estándar
    IMPLICIT NONE
    ! Variables de la subrutina
    SAVE
    INTEGER, INTENT(OUT) :: N              ! Grados de libertad del sistema
    INTEGER, INTENT(OUT) :: TMOD, TEXC     ! Tipo de modelo y excentricidad
    REAL, INTENT(OUT) :: B, A              ! Dimensiones planta tipo
    REAL, INTENT(OUT) :: W                 ! Peso por nivel
    REAL, DIMENSION(1000) :: ACX, ACY      ! Arreglo de aceleraciones
    INTEGER, INTENT(OUT) :: NAX, NAY       ! Número de registros en X e Y
    INTEGER :: FREX, FREY, NP              ! Factores de reducción y número de pisos
    REAL :: RASP, EXC                      ! Relación de aspecto y excentricidad
    REAL :: HI, WUS                        ! Altura de entrepiso y peso por unidad de superficie
    REAL :: Z, FI                          ! Factor de zona sísmica y de importancia
    REAL :: S, CT                          ! Coeficiente de sitio y para el periodo
    REAL :: FEX, FEY                       ! Factores de escala en X e Y
    REAL :: DTX, DTY                       ! Incrementos de tiempo
    INTEGER :: I

    ! Entrada de datos desde la entrada estándar
    WRITE(*,*) 'Ingrese el identificador del sistema (IDEN):'
    READ(*,*) 

    WRITE(*,*) 'Ingrese TMOD (Tipo de modelo) y TEXC (Tipo de excentricidad):'
    READ(*,*) TMOD, TEXC

    WRITE(*,*) 'Ingrese NP (Número de pisos), FREX y FREY (Factores de reducción en X y Y):'
    READ(*,*) NP, FREX, FREY

    WRITE(*,*) 'Ingrese RASP (Relación de aspecto), B (Lado mayor de la planta),'
    WRITE(*,*) 'EXC (Excentricidad), HI (Altura entrepiso), y WUS (Peso por m2):'
    READ(*,*) RASP, B, EXC, HI, WUS

    WRITE(*,*) 'Ingrese Z (Factor de zona sísmica), FI (Factor de importancia),'
    WRITE(*,*) 'S (Coef de sitio) y CT (Coef para el periodo):'
    READ(*,*) Z, FI, S, CT

    WRITE(*,*) 'Ingrese NAX (Número de registros en X) y el factor de escala FEX'
    WRITE(*,*) 'y DTX (Incremento de tiempo en X):'
    READ(*,*) NAX, FEX, DTX
    IF (NAX > 0) THEN
        WRITE(*,*) 'Ingrese los valores de aceleraciones en X (ACX):'
        DO I = 1, NAX
            READ(*,*) ACX(I)
            ACX(I) = ACX(I) * FEX
        END DO
    END IF

    WRITE(*,*) 'Ingrese NAY (Número de registros en Y) y el factor de escala FEY'
    WRITE(*,*) 'y DTY (Incremento de tiempo en Y):'
    READ(*,*) NAY, FEY, DTY
    IF (NAY > 0) THEN
        WRITE(*,*) 'Ingrese los valores de aceleraciones en Y (ACY):'
        DO I = 1, NAY
            READ(*,*) ACY(I)
            ACY(I) = ACY(I) * FEY
        END DO
    END IF

    ! Cálculos finales
    N = 3 * NP
    A = B / RASP
    W = A * B * WUS

    WRITE(*,*) 'GRADOS DE LIBERTAD=', N
    WRITE(*,*) 'ANCHO=', A
    WRITE(*,*) 'PESO=', W
END SUBROUTINE
