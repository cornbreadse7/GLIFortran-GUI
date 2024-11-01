SUBROUTINE MATMAS(N,B,A,W,MASA)
!OBJETIVO: FORMAR LA MATRIZ DE MASAS DEL SISTEMA

IMPLICIT NONE
!Variables de lista subrutina
INTEGER, INTENT(IN) :: N										!Grados de libeertad del sistema
REAL, INTENT(IN)	:: B										!Dimension menor planta tipo
REAL, INTENT(IN)	:: A										!Dimensi�n mayor
REAL, INTENT(IN)	:: W										!Peso por nivel
REAL, INTENT(OUT), DIMENSION(N,N) :: MASA						!MATRIZ DE MASA DEL SISTEMA
!Variables internas
INTEGER :: NP													!N�mero de pisos
INTEGER :: I,J,ERR
REAL :: MA														!Masa por nivel
REAL :: MI														!Momento de inercia de entrepiso
!Abrir el archivo MASA.TXT si ya exsiste o crearlo si no existe
OPEN(UNIT=4, FILE='MASA.TXT', STATUS='REPLACE', ACTION='WRITE', IOSTAT=ERR)
Prueba1: IF (ERR == 0) THEN
			!FORMACI�N MATRIZ DE MASAS EN T/CM/S2

			DO I=1,N
				DO J=1,N
					MASA(I,J)=0.0
				END DO
			END DO
			NP=N/3
			MA=W/981.											!Factor para lograr T=0.1N
			MI=MA*10000*(A**2+B**2)/12
			WRITE(4,*)'MATRIZ DE MASA DIAGONALIZADA'
			DO I=1,2*NP
				MASA(I,I)=MA									
			END DO
			DO I=(2*NP+1),N
				MASA(I,I)=MI
			END DO
			DO I=1,N
				DO J=1,N
						WRITE(4,*)MASA(I,J)
				END DO
			END DO
			CLOSE(UNIT=4)
	ELSE Prueba1
		WRITE(*,10)ERR
	END IF Prueba1
10	FORMAT(' ','Error al abrir archivo MASA.TXT, IOSTAT=',I6)
	END SUBROUTINE


