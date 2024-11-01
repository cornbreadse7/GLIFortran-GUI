		Subroutine DATOS (ARCHIVO)
		
		IMPLICIT NONE
		CHARACTER(LEN=30), INTENT(IN)	::	ARCHIVO
		OPEN (UNIT=1,FILE='ARCHIVO.TXT',STATUS='OLD')
		!WRITE(*,*)'DATOS DEL SISTEMA'

		WRITE(1,*)'PLANTA-TORSION'
		WRITE(1,*)1,1							!Tipo Modelo TMOD y Excentricidad TEXC
		WRITE(1,*)3,2,2		 					!NP pisos, FREX FREY Factor reducci�n en X y Y
		WRITE(1,*)2.0,10.,0.1,3.0,0.75			!RASP B EXC HI WUS
		WRITE(1,*)0.3,1.						!Z Zona s�smica FI Factor importancia
		WRITE(1,*)1.2,0.0731					!s Coef. sitio, CT Coef. periodo CONCRETO
		WRITE(1,*)'PASEO-BRAVO'					!ACEX
		WRITE(1,*)0								!NAX
		WRITE(1,*)0.,0.							!FEX DTX
		WRITE(1,*)'PASEO-BRAVO'					!ACEY
		WRITE(1,*)843							!NAY
		WRITE(1,*)2.,0.1						!FEY DTY
		CLOSE (UNIT=1)
		WRITE(*,*)'YA HAY ARCHIVO'
		END SUBROUTINE

	
