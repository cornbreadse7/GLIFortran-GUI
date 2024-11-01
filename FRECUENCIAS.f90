SUBROUTINE FRECUENCIAS (N,MASA,RISI,MA)
!Objetivo: formar la matriz de amortiguamiento
!La matriz de rigidez se descompone en dos matrices tringulres, para resolver problema est�ndar de eigenvalores

IMPLICIT NONE
INTEGER, INTENT(IN)		   	   	  :: N											!Ordemn de las matrices
REAL, INTENT(IN), DIMENSION(N,N)   :: MASA
REAL, INTENT(IN), DIMENSION(N,N)   :: RISI
REAL, INTENT(OUT), DIMENSION(N,N) :: MA
!Variables internas
INTEGER :: I,J,II,K,ERR
INTEGER :: IMIN
REAL :: SUM,TEM
REAL :: A0,A1
REAL :: WI,WJ,T1,T2
REAL, DIMENSION(N,N) :: U													!Matriz triangular superior												  
REAL, DIMENSION(N,N) :: UI													!Matriz invsersa
REAL, DIMENSION(N,N) :: UTI													!Matriz inversa transpuesta
REAL, DIMENSION(N,N) :: KUTI												!K*UIT
REAL, DIMENSION(N,N) :: UKU													!UI*K*UIT
REAL, DIMENSION(N,N) :: EV													!Vector no caracteristico
REAL, DIMENSION(N,N) :: XF													!Transformaci�n de vectores 
REAL, DIMENSION(N)   :: ARR
CHARACTER(LEN=20)	 :: FRECUE

	

OPEN(UNIT=7, FILE= 'FRECUE.TXT', STATUS= 'REPLACE', ACTION= 'WRITE', IOSTAT=ERR)
PRUE:   IF (ERR == 0)THEN
			WRITE(7,*)'MATRIZ DE AMORTIGUAMIENTO '

			CALL DESCOM(MASA,U,N)											!Descomposici�n matriz M
			DO I=1,N														!Inicializa UI
				DO J=1,N
					UI(I,J)=0.0
				END DO
			END DO
			DO I=1,N
				DO J=1,N
					WRITE(*,*)U(I,J)
				END DO
			END DO
			DO I=1,N
				UI(I,I)=1.0/U(I,I)												!Invsersa UI
			END DO
	    DO J=1,N
			DO II=1,N
				I=N-II+1
				IF(I >= J) CYCLE
					SUM=0.0
					DO K=(I+1),3
						SUM=SUM+U(I,K)*UI(K,J)
					END DO
					UI(I,J)=-SUM/U(I,I)
			END DO
		END DO
		DO I=1,N
			DO J=1,N
				UTI(I,J)=UI(J,I)										!Matriz UTI

			END DO
		END DO
		CALL MULTIMA(KUTI,RISI,UTI,N,N,N)
		CALL MULTIMA(UKU,UI,KUTI,N,N,N)
		CALL JACOBI(UKU,N,EV)
		CALL MULTIMA(XF,UTI,EV,N,N,N)
		WRITE(7,*)'MATRIZ UKU '
		DO I=1,N
			ARR(I)=UKU(I,I);		WRITE(7,*)UKU(I,I)
		END DO;	WRITE(7,*)'VECTORES CARACTERISTICOS'
		DO I=1,N
			DO J=1,N
				WRITE(7,*)XF(I,J)										!Archivo eigenvectores
			END DO
		END DO
		DO I=1,N-1
			IMIN=I
			DO J=(I+1),N
				IF( ARR(J) < ARR(IMIN))THEN
					IMIN=J
				END IF
			END DO										 
			IF( I <= IMIN)THEN
				TEM			=ARR(I)
				ARR(I)		=ARR(IMIN)
				ARR(IMIN)	=TEM
			END IF
		END DO
		WRITE(7,*)'ARREGLO DE FRECUENCIAS'
		do i=1,n
		   write(7,*)arr(i)
		end do
		WRITE(*,*)
		!Amortiguamiento de Rayleigh
	
		WI=(ARR(1))**0.5; WJ=(ARR(2))**0.5
		WRITE(7,*)'FRECUENCIAS W1 W2',WI,WJ
		T1=6.2832/WI;	T2=6.2832/WJ
		WRITE(7,*) 'PERIODOS T1 T2', T1,T2
		A0=0.05*(2.*WI*WJ)/(WI+WJ);				A1=(0.05*2.)/(WI+WJ)
		WRITE(7,*)'CONSTANTES A0 A1:',A0, A1
		WRITE(7,*)'MATRIZ DE AMORTIGUAMIENTO'
		DO I=1,N
			DO J=1,N
				MA(I,J)=0.0
				MA(I,J)=A0*MASA(I,J)+A1*RISI(I,J)
				WRITE(7,*)MA(I,J)
			END DO
		END DO
		CLOSE(UNIT=7)
	ELSE PRUE
		WRITE(*,10)ERR
	END IF Prue
10 FORMAT('','ERROR ABRIENDO ARCHIVO FRECUE, IOSTAT=',I6)

	END SUBROUTINE
