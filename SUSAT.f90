  SUBROUTINE SUSAT(N,Y,U,X)
	  !U*x=y
	  IMPLICIT NONE
	  INTEGER, INTENT(IN)				:: N
	  REAL, INTENT(IN), DIMENSION(N,N)	:: U
	  REAL, INTENT(IN), DIMENSION(N)	:: Y
	  REAL, INTENT(OUT), DIMENSION(N)	:: X
	  !Lista de variables internas
	  INTEGER		:: I,J,K
	  REAL			:: SUMA

	  X(N)=Y(N)/U(N,N)
	  DO J=2,N
		I=N-J+1
		SUMA=0.0
		DO K=(I+1),N
			SUMA=SUMA+U(I,K)*X(K)
		END DO
		X(I)=(Y(I)-SUMA)/U(I,I)
	  END DO
	  WRITE(*,*)'TERMINA SUSAT'

	  END SUBROUTINE