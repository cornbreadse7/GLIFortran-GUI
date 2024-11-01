		SUBROUTINE SOLUELA(A,N,P)
		!Objetivo: Resolver el caso Est�tico por Cholesky

		IMPLICIT NONE

		INTEGER, INTENT(IN)					::	N
		REAL, INTENT(IN), DIMENSION(N,N)	::	A
		REAL, INTENT(IN), DIMENSION(N)		::	P
			
		!Variables internas
		INTEGER	::	I,J,K,SUM,ERR,NP
		REAL, DIMENSION(N,N)				::	U
		REAL, DIMENSION(N)					::	Y, F
		REAL, DIMENSION(N)					::	DE


	OPEN(UNIT=9, FILE= 'SOLE.TXT', STATUS= 'REPLACE', ACTION= 'WRITE', IOSTAT=ERR)

	
	PRUE:	IF(ERR == 0) THEN

		 WRITE(9,*)'VECTOR DE FUERZAS P'

		DO I=1,N
			F(I)=0
			WRITE(9,*)P(I)
		END DO
		NP=N/3

		
		IF (NP ==1) THEN
		F(1)=P(1)
		F(2)=P(2)
		F(3)=P(3)
		END IF
	
		IF(NP == 2) THEN

		F(1)=P(1)
		F(2)=P(4)
		F(3)=P(2)
		F(4)=P(5)
		F(5)=P(3)
		F(6)=P(6)
		END IF
	
		IF(NP ==3) THEN
		F(1)=P(1)
		F(2)=P(4)
		F(3)=P(7)
		F(4)=P(2)
		F(5)=P(5)
		F(6)=P(8)
		F(7)=P(3)
		F(8)=P(6)
		F(9)=P(9)

		END IF
				
		DO I=1,N
			WRITE(*,*)F(I)
		END DO
			 	

		!Inicializaci�n a cero
		NP=N/3
		DO I=1,N
			
			DO J=1,N
				U(I,J)=0.0
			END DO
		END DO		
			DO I=1,NP
				U(I,I)=SQRT(A(I,I))

				
				DO J=I+1,N
					U(I,J)=A(I,J)/U(I,I)
				END DO
			END DO

				DO I=NP+1,N
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
						U(I,J)=(A(I,J)-SUM)/U(I,I);		!write(*,*)u(I,J)
							

					END DO
			END DO

		
			WRITE(9,*)'MATRIZ U'
		
			
			DO I=1,N
				DO J=1,N
					WRITE(9,*)U(I,J)
				END DO
			END DO
			WRITE(9,*)'VECTOR Y'

			Y(1)=F(1)/U(1,1);	WRITE(9,*)Y(1)
	  DO I=2,N
		SUM=0.0
		DO K=1,I-1
			SUM=SUM+U(K,I)*Y(K)
		END DO
		Y(I)=(F(I)-SUM)/U(I,I);	write(9,*)y(i)
	  END DO
	  WRITE(*,*)'TERMINA SUSAD'

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


			WRITE(9,*)'DESPLAZAMIENTOS ELASTICOS '
			DO I=1,N

				WRITE(9,*)DE(I)
				WRITE(*,*)DE(I)
			END DO
			CLOSE(UNIT=9)
		ELSE PRUE
		WRITE(*,100)ERR
		END IF PRUE
	100	FORMAT(' ','ERROR ABRIENDO ARCHIVO SOLE.TXT, IOSTAT='I6)
		END SUBROUTINE

