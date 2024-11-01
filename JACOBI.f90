SUBROUTINE JACOBI(D,N,E)					 
!Objetivo: obtener las frecuencias y los eigenvalores de una matriz simétrica
IMPLICIT NONE
INTEGER, INTENT(IN)					:: N									!Orden de la matriz
REAL, DIMENSION(N,N), INTENT(INOUT) :: D
REAL, DIMENSION(N,N), INTENT(OUT)   :: E
!Variables internas
INTEGER, PARAMETER :: ITMAX=100
INTEGER :: ITER,I,J
INTEGER :: IR,IC
REAL, PARAMETER :: EPS=1.0E-05												!Convergencia
REAL :: ZZ,YY,ZZZ,YYY
REAL :: TANZ,SINZ,COSZ
REAL :: DIF
!Inicializar matriz E						
DO I=1,N
	 DO J=1,N
		E(I,J)=0.0;						E(I,I)=1.0
	 END DO
END DO
DO ITER=0,ITMAX-1
	ZZ=0.0
	DO I=1,N-1
		DO J=I+1,N
			IF(ABS(D(I,J)) <= ZZ) CYCLE
			ZZ=ABS(D(I,J))
			IR=I;	IC=J
		END DO													 
	END DO
	IF(ITER == 0)THEN
		YY=ZZ*EPS
	ELSE
	END IF
	IF(ZZ <= YY)EXIT
		DIF=D(IR,IR)-D(IC,IC)
		TANZ=(-DIF+SQRT(DIF**2+4.0*ZZ**2))/(2.0*D(IR,IC))
		COSZ=1.0/SQRT(1.0+TANZ**2);	SINZ=COSZ*TANZ
		DO I=1,N
			ZZZ=E(I,IR)
			E(I,IR)=COSZ*ZZZ+SINZ*E(I,IC);	E(I,IC)=COSZ*E(I,IC)-SINZ*ZZZ
		END DO
		DO I=1,N
			IF(I == IR) EXIT
				YYY=D(I,IR)
				D(I,IR)=COSZ*YYY+SINZ*D(I,IC);		D(I,IC)=COSZ*D(I,IC)-SINZ*YYY
		END DO
		DO I=IR+1,N
			IF(I == IC)EXIT
				YYY=D(IR,I)
				D(IR,I)=COSZ*YYY+SINZ*D(I,IC);		D(I,IC)=COSZ+D(I,IC)-SINZ*YYY
		END DO
		DO I=IC+1,N
			ZZZ=D(IR,I)
			D(IR,I)=COSZ*ZZZ+SINZ*D(IC,I);			D(IC,I)=COSZ*D(IC,I)-SINZ*ZZZ
		END DO
		YYY=D(IR,IR)
		D(IR,IR)=YYY*COSZ**2+D(IR,IC)*2.0*COSZ*SINZ+D(IC,IC)*SINZ**2
		D(IC,IC)=D(IC,IC)*COSZ**2+YYY*SINZ**2-D(IR,IC)*2.0*COSZ*SINZ
		D(IR,IC)=0.0
	END DO

	WRITE(*,*)'MATRIZ DINAMICA'
	END SUBROUTINE

