		  SUBROUTINE SUSAD(N,U,P,Y)
	  !U*y=b
	  IMPLICIT NONE
	  INTEGER, INTENT(IN)				:: N
	  REAL, INTENT(IN), DIMENSION(N,N)	:: U
	  REAL, INTENT(IN), DIMENSION(N)	:: P
	  !Variables internas
	  INTEGER				:: I,K
	  REAL, DIMENSION(N)	:: Y
	  REAL					:: X

	  Y(I)=P(1)/U(1,1)
	  DO I=2,N
		X=0.0
		DO K=1,I-1
			X=X+U(K,I)*Y(K)
		END DO
		Y(I)=(P(I)-X)/U(I,I)
	  END DO
	  WRITE(*,*)'TERMINA SUSAD'
	  END SUBROUTINE
