 SUBROUTINE MATRIG(N,TEXC,B,A,W,Z,FI,S,CT,HI,EXC,FREX,FREY,MASA,RISI,P)
 !OBJETIVO: MATRIZ DE RIGIDEZ DEL SISTEMA,A PARTIR DEL PERIODO, 
 !CORTANTE SISMICO EN 2 DIRECCIONES, CORTANTE DIIRECTO, POR TORSI�N, 
 !SE CONSIDERA EXCENTRICIDAD ACCIDENTAL
 
 IMPLICIT NONE
 !Variables lista de subrutina
 INTEGER, INTENT(IN) :: N,TEXC
 INTEGER, INTENT(IN) :: FREX,FREY
 REAL, INTENT(IN) :: Z,FI
 REAL, INTENT(IN) :: S,CT
 REAL, INTENT(IN) :: A,B
 REAL, INTENT(IN) :: W,HI
 REAL, INTENT(IN) :: EXC
 REAL, INTENT(OUT), DIMENSION(N)	:: P

 REAL, INTENT(OUT), DIMENSION(N,N) ::  RISI
 REAL, DIMENSION(N,N)			   ::  MASA
 REAL, DIMENSION(N,N)			   ::  MA	
 !Varriables internas
 INTEGER :: NP,ERR
 INTEGER :: I,J,K,L
 REAL :: TX,TY
 REAL :: CX,CY
 REAL :: VX,VY
 REAL :: X,PEN
 REAL :: YO

 REAL, DIMENSION(5,N/3) :: DRI
 REAL, DIMENSION(5,N/3)	:: DY	
 REAL, DIMENSION(N/3)	:: XO
 REAL, DIMENSION(N/3,N/3) :: KM1,KM2,KM3,KM4,KM5
 !Cortante basal en ambas direcciones
 !Periodo por el m�todo A del UBC-94
 OPEN(UNIT=5, FILE='RIGI.TXT', STATUS='REPLACE', ACTION='WRITE', IOSTAT=ERR)
 PRUE1: IF (ERR == 0) THEN
	NP=N/3;	
	WRITE(*,*)		'NUMERO DE PISOS',NP
	TX=CT*(NP*HI)**(3./4.);	TY=CT*(NP*HI)**(3./4.)
	WRITE(5,*) 'TIPO EXC ',	TEXC
	WRITE(5,*)'PERIODOS',	TX,TY
	CX=1.25*S/(TX**(2./3.));	CY=1.25*S/(TY**(2./3.))
	IF(CX > 2.75) THEN
		CX=2.75
	END IF
	IF(CY > 2.75) THEN
		CY=2.75
	END IF
	!Cortante basal en X e Y
	VX=Z*FI*CX*NP*W/(1*FREX);	VY=Z*FI*CY*W*NP/(1*FREY)
	X=(3*B/(B-2.*EXC))-2;		WRITE(*,*)X,EXC
	WRITE(*,*)'CORTANTES BASALES:', VX,VY;	WRITE(*,*)
	WRITE(5,*) 'CORTANTES BASALES:', VX,VY
	!Distribuci�n de Cortante
	DO I=1,5
		DO J=1,NP
			DRI(I,J)=1.0
		END DO
	END DO															
	IF(TEXC==1)THEN									!Excentricidad constante
		DO I=1,NP
	
			DRI(1,I)=X
		END DO
	ELSE
		IF(TEXC==2)THEN								!Excentricidad lineal ascendente (m�x=0.2)
			PEN=HI*(NP-1)/0.1; YO=HI;	XO(1)=0.1
			DO I=2,NP
				XO(I)=YO/PEN+0.1;	YO=YO+HI
			END DO
			DO I=1,NP
				X=(3*A/(A-2.*XO(I)*B))-2.0;	DRI(1,I)=X
			END DO
		ELSE
			IF(TEXC==3)THEN							!Excentricidad lineal ascendente (m�x=0.3)
	
				PEN=HI*(NP-1)/0.2;	YO=HI;	XO(1)=0.1
				DO I=2,NP
					XO(I)=YO/PEN+0.1;	YO=YO+HI
				END DO
				do i=1,np
					x=(3*A/(A-2.*xo(i)*b))-2.;	DRI(1,I)=X
				END DO
			ELSE	
				IF(TEXC==4)THEN						!Excentricidad alternada
					J=1
					DO I=1,(NP+1)/2
						DRI(I,J)=X
						J=J+2
					END DO
					J=2
					DO I=1,NP/2
						DRI(3,J)=X
						J=J+2
					END DO
				END IF
			END IF
		END IF
	END IF
	!Asignar rigideces
	DO I=1,NP
		DRI(1,I)=20.*DRI(1,I)/(X+2.)	
		DO J=2,3
			DRI(J,I)=20.*(1./(X+2.))*DRI(J,I)
		END DO
	END DO
	DO I=1,NP
		DO J=4,5
			DRI(J,I)=10.*DRI(J,I)
		END DO
	END DO
	
	WRITE(*,*)'DISTRIBUCION DE RIGIDECES'
	DO J=1,5
		WRITE(*,*)(DRI(J,I),I=1,N/3)
	END DO;	
	WRITE(*,*)
	WRITE(5,*)A,B,FREX,FREY
	!Matriz de rigidez lateral de cada elemento KM#
	DO I=1,NP
		DO J=1,NP
			KM1(I,J)=0.0;	KM2(I,J)=0.0;	KM3(I,J)=0.0;	KM4(I,J)=0.0; KM5(I,J)=0.0
		END DO
	END DO
	IF(NP==1)THEN														!UN SOLO NIVEL
		KM1(1,1)=DRI(1,1);	KM2(1,1)=DRI(2,1);	KM3(1,1)=DRI(3,1)
		KM4(1,1)=DRI(4,1);	KM5(1,1)=DRI(5,1)
		
	ELSE
	J=2
		DO I=1,(NP-1)
			KM1(I,I)=DRI(1,I)+DRI(1,J);	KM1(J,I)=-DRI(1,J);	KM1(I,J)=KM1(J,I)
			KM2(I,I)=DRI(2,I)+DRI(2,J); KM2(J,I)=-DRI(2,J);	KM2(I,J)=KM2(J,I)
			KM3(I,I)=DRI(3,I)+DRI(3,J); KM3(J,I)=-DRI(3,J); KM3(I,J)=KM3(J,I)
			KM4(I,I)=DRI(4,I)+DRI(4,J); KM4(J,I)=-DRI(4,J); KM4(I,J)=KM4(J,I)
			KM5(I,I)=DRI(5,I)+DRI(5,J); KM5(J,I)=-DRI(5,J); KM5(I,J)=KM5(J,I)
			J=J+1
		END DO
		KM1(NP,NP)=DRI(1,NP);	KM2(NP,NP)=DRI(2,NP);	KM3(NP,NP)=DRI(3,NP)
		KM4(NP,NP)=DRI(4,NP);	KM5(NP,NP)=DRI(5,NP)		
	
	END IF
	!Matriz de rigidez Direcci�n X
	WRITE(5,*)'MATRIZ DE RIGIDEZ DIR X'
	DO I=1,NP
		DO J=1,NP
			RISI(I,J)=KM4(I,J)+KM5(I,J)
			WRITE(5,*)RISI(I,J)
		END DO
	END DO
	
	!Matriz de rigidez acoplada en Direcci�n Y
	WRITE(5,*)'MATRIZ DE RIGIDEZ ACOPLADA DIR Y'
	DO I=(N-NP),N
		DO J=(N-NP),N
			RISI(I,J)=0.0
		END DO
	END DO

	K=NP+1
	DO I=1,NP
		L=NP+1
		DO J=1,NP
			RISI(K,L)=KM1(I,J)+KM2(I,J)+KM3(I,J)	
			L=L+1
		END DO
		K=K+1
	END DO
	K=2*NP+1
	DO I=1,NP
		L=NP+1
		DO J=1,NP
			RISI(K,L)=(-KM1(I,J)+KM3(I,J))*100*B/2.
			RISI(L,K)=RISI(K,L);   L=L+1
		END DO
		K=K+1							 
	END DO
	K=2*NP+1
	DO I=1,NP
		L=2*NP+1
		DO J=1,NP
			RISI(K,L)=(KM1(I,J)+KM3(I,J))*(B*100/2)**2+(KM4(I,J)+KM5(I,J))*(A*100/2)**2; L=L+1
		END DO		
		K=K+1
	END DO
	WRITE(5,*)'MATRIZ DE RIGIDECES RISI'
	DO I=1,3*NP
		DO J=1,3*NP
			WRITE(5,*)RISI(I,J)
		END DO
	END DO

	CALL DISCOR(N,VX,VY,DRI,DY,P,A,B,EXC)

	WRITE(*,*)'VECTOR DE FUERZAS'
	DO I=1,N
		WRITE(*,*)P(I)
	END DO; WRITE(*,*)


	CLOSE(UNIT=5)		
	ELSE PRUE1
		write(*,10)ERR
	end if PRUE1

	10 format('','Error al abrir archivo RIGI.TXT, IOSTAT=',I6)
	END SUBROUTINE
