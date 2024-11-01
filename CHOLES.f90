	  SUBROUTINE CHOLES(U,N,P)
	  !Objetivo: resolver sistema de ecuaciones por el método de Cholesky
	  IMPLICIT NONE
	  !Lista variables subrutina
	  INTEGER, INTENT(IN)				:: N									!Orden de la matriz
	  REAL, INTENT(IN), DIMENSION(N)	:: P									 !Vector independiente
	  REAL, INTENT(IN),	DIMENSION(N,N)	:: U									 !Matriz triangular superior

	  REAL,	DIMENSION(N)	:: Y	
	  REAL,	DIMENSION(N)	:: DE

	  !Lista de variables internas	   				  																			 
	  
	  INTEGER				:: I,J,K
	  REAL			:: SUM
	  WRITE(*,*)'INICIA SUSTITUCION HACIA ADELANTE'
	  READ(*,*)

	  Y(I)=P(1)/U(1,1)
	  DO I=2,N
		SUM=0.0
		DO K=1,I-1
			SUM=SUM+U(K,I)*Y(K)
		END DO
		Y(I)=(P(I)-SUM)/U(I,I);	write(*,*)y(i)
	  END DO
	  WRITE(*,*)'TERMINA SUSAD'

	  								
	!	CALL SUSAD(N,U,P,Y)														  !Vector resultado sust hacia adelante

		DE(N)=Y(N)/U(N,N)							
		DO J=2,N
			I=N-J+1
			SUM=0.0
			DO K=(I+1),N
				SUM=SUM+U(I,K)*DE(K)
			END DO
			DE(I)=(Y(I)-SUM)/U(I,I)
		END DO
		WRITE(*,*)'TERMINA SUSAT'
	DO I=1,N
	  WRITE(*,*)DE(I)
	 END DO

	!	CALL SUSAT(N,Y,U,X)
	  END SUBROUTINE


	  

	  
	  
