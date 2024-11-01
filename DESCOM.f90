SUBROUTINE DESCOM(A,U,N)
!Descompone matriz A por el m�todo de triangulaci�n de Cholesky
IMPLICIT NONE
INTEGER, INTENT(IN) :: N
REAL, INTENT(IN),  DIMENSION(N,N) :: A
REAL, INTENT(OUT), DIMENSION(N,N) :: U
!Variables internas
INTEGER :: I,J,K
REAL :: SUM
DO I=1,N
	DO J=1,N
		U(I,J)=0.0
	END DO
END DO
	
	U(1,1)=SQRT(A(1,1))
	DO J=2,N
		U(1,J)=A(1,J)/U(1,1)
	END DO
	
DO I=2,N
	SUM=0.0
	DO K=1,(I-1)
		SUM=SUM+U(K,I)**2
	END DO	
	U(I,I)=SQRT(A(I,I)-SUM)

	IF(I == N)EXIT
	
	DO J=(I+1),N
		SUM=0.0
		DO K=1,(I-1)
			SUM=SUM+U(K,I)*U(K,J)	
		END DO
			U(I,J)=(A(I,J)-SUM)/U(I,I)
	END DO
END DO


	
	WRITE(*,*)'TERMINA DESCOM'
	WRITE(*,*)

END SUBROUTINE

		
