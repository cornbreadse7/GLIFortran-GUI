   SUBROUTINE DISCOR(N,VX,VY,DRI,DY,P,A,B,EXC)
	!OBJETIVO:Distribución de cortante en todos los niveles
	IMPLICIT NONE
	!Variables subrutina
	INTEGER, INTENT(IN) :: N							!Grados de libertad, 
	REAL, INTENT(IN) :: A,B,EXC
	REAL, INTENT(IN) :: VX,VY							!Cortantes basales
	REAL, INTENT(INOUT), DIMENSION(5,N/3)	:: DRI		!Arreglo con distribuci�n de rigideces
	REAL, INTENT(OUT), DIMENSION(5,N/3)		:: DY
	REAL, INTENT(OUT),	DIMENSION(N)		:: P		!Desplazamiento en la fluencia
	!Variables internas
	INTEGER :: I,J
	INTEGER :: NP
	REAL :: E1X,E2X,E1Y,E2Y								!Excentricidades
	REAL :: MT1X,MT2X,MT1Y,MT2Y,MTOX,MTOY
	REAL :: RI											!Contador reales
	REAL :: SUMX,SUMY,SUM,SUMY1,SUMY2,SUMX1,SUMX2
	REAL :: XTO,YTO										!Coordenadas centro de torsi�n						 
	REAL, DIMENSION(5)		:: CD,CTO,XT				!Factor cortante directo, por torsi�n, distancia a CT
	REAL, DIMENSION(5)		:: RX,RXT,RXT2				!PRODUCTOS: rigidez por distancias
	REAL, DIMENSION(5)		:: V1,V2					!Cortantes por torsi�n
	REAL, DIMENSION(5)		:: VM,VO					!Cortante m�ximo y por torsi�n transversal
	REAL, DIMENSION(5)		:: VXY1,VXY2				!Cortante m�ximo m�s 0.3 dir transversal
	REAL, DIMENSION(N/3)	:: DVV,F					!Facor distribuci�n vertical cortante, fuerza
	REAL, DIMENSION(5,N/3)	:: DV
	

														!Distribuci�n de cortantes
	!Momentos de torsi�n en planta

	E1Y=0.05*B;				E2Y=-0.05*B
	E1X=EXC*B+0.05*A;		E2X=-0.05*A
	MT1X=E1Y*VX;			MT2X=E2Y*VX
	MT1Y=E1X*VY;			MT2Y=E2X*VY
	MTOX=MT1Y;				MTOY=MT1X

							!Cortante dise�o (directo+torsi�n+0.3 direcci�n perpendicular
	NP=N/3
	DO J=1,NP															
		SUMX=0.0; SUMY=0.0; SUMX1=0.0; SUMY1=0.0; SUMX2=0.0; SUMY2=0.0
		DO I=1,3
			SUMY=SUMY+DRI(I,J)
		END DO
		RX(1)=0.0; RX(2)=DRI(2,J)*A/2.;	RX(3)=DRI(3,J)*A	!Sumatoria de productos
		DO I=1,3																		  
			SUMY1=SUMY1+RX(I)
		END DO
		XTO=SUMY1/SUMY
		XT(1)=-XTO; XT(2)=A/2.-XTO; XT(3)=XT(2)+A/2.
		DO I=1,3
			RXT(I)=DRI(I,J)*XT(I); RXT2(I)=RXT(I)*XT(I)
			SUMY2=SUMY2+RXT2(I)
		END DO
		DO I=4,5
			SUMX=SUMX+DRI(I,J)
		END DO
		RX(4)=0.0; RX(5)=DRI(5,J)*B
		DO I=4,5
			SUMX1=SUMX1+RX(I)
		END DO
		YTO=SUMX1/SUMX
		XT(4)=-YTO; XT(5)=XT(4)+B
		DO I=4,5
			RXT(I)=DRI(I,J)*XT(I); RXT2(I)=RXT(I)*XT(I)
			SUMX2=SUMX2+RXT2(I)
		END DO
		DO I=1,5											!Coeficiente por torsi�n
			CTO(I)=RXT(I)/(SUMX2+SUMY2)
		end do
		DO I=1,3
			CD(I)=DRI(I,J)/SUMY;	DV(I,J)=CD(I)*VY
			V1(I)=CTO(I)*MT1Y;		V2(I)=CTO(I)*MT2Y
		END DO
		DO I=4,5
			CD(I)=DRI(I,J)/SUMX;	DV(I,J)=CD(I)*VX		!Cortante directto direcci�n X
			V1(I)=CTO(I)*MT1X;		V2(I)=CTO(I)*MT2X
		END DO
		!Cortantes m�ximos
		VM(1)=DV(1,J)-V2(1);	VM(2)=DV(2,J)+V1(2);	VM(3)=DV(3,J)+V1(3)
		VM(4)=DV(4,J)+V2(4);	VM(5)=DV(5,J)+V1(5)
		DO I=1,3											!Cortantes finales
			VO(I)=CTO(I)*MTOY
			VXY1(I)=VM(I)+0.3*ABS(VO(I));				VXY2(I)=0.3*VM(I)+ABS(VO(I))
			IF (VXY1(I) >= VXY2(I)) THEN
				DV(I,J)=VXY1(I)
			ELSE
				DV(I,J)=VXY2(I)
			END IF
		END DO
		DO I=4,5
			VO(I)=CTO(I)*MTOX
			VXY1(I)=VM(I)+0.3*ABS(VO(I));				VXY2(I)=0.3*VM(I)+ABS(VO(I))
			IF(VXY1(I) >= VXY2(I))THEN
				DV(I,J)=VXY1(I)
			ELSE
				DV(I,J)=VXY2(I)
			END IF
		END DO
	END DO
	!Distribuci�n vertical cortante basal
	SUM=0.0
	DO I=1,NP
		RI=REAL(I);										SUM=SUM+RI
	END DO
	WRITE(*,*)SUM
	DO J=1,NP
		F(J)=J/SUM
	END DO
	DVV(NP)=F(NP)
	DO J=(NP-1),1,-1
		DVV(J)=DVV(J+1)+F(J)
	END DO
	WRITE(5,*)'DISTRIBUCION DE RIGIDECES '
	DO J=1,NP
		DO I=1,5
			DRI(I,J)=DVV(J)*DRI(I,J);		WRITE(5,*)DRI(I,J)	!Distribuci�n rigideces
		end do
	END DO
	WRITE(5,*)'DISTRIBUCION DE CORTANTES DV'
		DO J=1,NP
			 DO I=1,5
				DV(I,J)=DVV(J)*DV(I,J);		WRITE(5,*)DV(I,J)	!Distribuci�n cortantes
			end do
		end do;	WRITE(5,*)'DESPLAZAMIENTOS EN LA FLUENCIA DY'
		DO J=1,NP
			DO i=1,5
				DY(I,J)=DV(I,J)/DRI(I,J);	WRITE(5,*)DY(I,J)	!Desplazanientos fluencia
			END DO

		END DO
			WRITE(5,*)'VECTOR DE FUERZAS'

			P(1)=DV(4,1)+DV(5,1)
			P(2)=DV(1,1)+DV(2,1)+DV(3,1)
			P(3)=P(1)*A*100/2+P(2)*B*100/2

			IF(NP ==2) THEN

			P(4)=DV(4,2)+DV(5,2)
			P(5)=DV(1,2)+DV(2,2)+DV(3,2)
			P(6)=P(4)*A*100/2+P(5)*B*100/2

			P(1)=P(1)-P(4)
			P(2)=P(2)-P(5)
			P(3)=P(3)-P(6)
			ELSE

			IF(NP ==3) THEN


			P(4)=DV(4,2)+DV(5,2)
			P(5)=DV(1,2)+DV(2,2)+DV(3,2)
			P(6)=P(4)*A*100/2+P(5)*B*100/2

			P(7)=DV(4,3)+DV(5,3)
			P(8)=DV(1,3)+DV(2,3)+DV(3,3)
			P(9)=P(7)*A*100/2+P(8)*B*100/2

			P(1)=P(1)-P(4)
			P(2)=P(2)-P(5)
			P(3)=P(3)-P(6)
			P(4)=P(4)-P(7)
			P(5)=P(5)-P(8)
			P(6)=P(6)-P(9)


			END IF


			END IF


			 DO I=1,N
				WRITE(*,*)P(I)
				WRITE(5,*)P(I)
			END DO
	
	10 FORMAT(' ','ERROR al abrir archivo DISTRI.TXT, IOSTAT =', I6)
	END SUBROUTINE


					   