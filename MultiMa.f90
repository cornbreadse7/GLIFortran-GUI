Subroutine MULTIMA (A,B,C,L,M,N)
! Objettivo: multiplicar dos matrices A=B*C
IMPLICIT NONE
INTEGER, INTENT(IN) :: L,M,N
REAL, INTENT(IN) :: B(L,M),C(M,N)
REAL, INTENT(OUT) :: A(L,N)
INTEGER :: I,J,K

DO I=1,L
	DO J=1,N
		A(I,J)=0.0
		DO K=1,M
			A(I,J)=A(I,J)+B(I,K)*C(K,J)
		END DO
	END DO
END DO
END SUBROUTINE
