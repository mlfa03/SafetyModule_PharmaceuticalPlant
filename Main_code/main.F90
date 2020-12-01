PROGRAM batch_final

USE parametros
!USE dfport

IMPLICIT NONE

!******************************************************************************************
! Declaring the variables of the subroutines of the integration method DASSL

INTEGER :: np, i
REAL*8 :: dt, t, tout, tini, tfinal 
INTEGER :: idid, ires
INTEGER, DIMENSION(15)  :: info
INTEGER, DIMENSION(liw) :: iwork
INTEGER, DIMENSION(neq) :: ipar
REAL*8, DIMENSION(lrw)  :: rwork
REAL*8, DIMENSION(neq)  :: rpar 
REAL*8, DIMENSION(neq)  :: yprime, delta,y
REAL*8, DIMENSION(neq)  :: rtol, atol
REAL*8, DIMENSION(3)  :: VAR
!REAL*8,DIMENSION(8):: Yp
REAL*8 P_dead, IPD

INTEGER aux1, aux2

EXTERNAL JAC, RES
OPEN(10,file='conversion15.dat', status='unknown', action='write')
OPEN(20,file='Pressure.txt', status='unknown', action='write' )
OPEN(30,file='Energy.txt', status='unknown', action='write' )
OPEN(40,file='Volume.txt', status='unknown', action='write' )
OPEN(50,file='Output.txt', status='unknown', action='write' )
OPEN (60, file = 'time.dat', status = 'unknown', action = 'write')
OPEN(70, file = 'UA1000.dat', status = 'unknown', action = 'write')
OPEN (80, file = 'fail200s.dat', status = 'unknown', action = 'write')
!******************************************************************************************

np= 720 !np = 2000
tini=0.0d0
tfinal=  10800.0d0 
!Initial conditions
Y(1) = 15/MM_Pbenz    !0.15
y(2) = 0.1696/MM_HQ  ! considering the mass calculation of inhibitor at 70 degrees celsius  --- 100 ppm of inhibitor

!Simulations of inhibitor failure
!Y(2) = 0.1696*5/MM_HQ ! 500 PPM INHIBITOR FAILURE
!Y(2) = 1.696/MM_HQ ! 1000 PPM INHIBITOR FAILURE
!Y(2) = 0.1696*15/MM_HQ ! 1500 PPM INHIBITOR FAILURE
!Y(2) = 0.1696*20/MM_HQ ! 2000 PPM INHIBITOR FAILURE
!Y(2) = 0.1696*25/MM_HQ ! 2500 PPM INHIBITOR FAILURE
!Y(2) = 0.1696*30/MM_HQ ! 3000 PPM INHIBITOR FAILURE
Y(3) = 1500/MM_MMA
Y(4) = 1.d-5
Y(5) = 1.d-5   
Y(6) = 1.d-5
y(7) = 343.15 !353.15  
y(8) = 343.15 ! 353.15

Temp=y(7)
Tc=y(8)

dens_MMA = 9.654d-1 - 1.09d-3*(Temp-273.15)-9.7d-7*((Temp-273.15)**2) !g/cm3 
densDi = dens_MMA/(0.754 - 9.d-4*(Temp-343.15))
VolMMA  = y(3)*MM_MMA/dens_MMA  !mL
VolDi  = (y(5)+lambda_1)*MM_MMA/densDi    
Magua = 4500.d0
Volh2o = Mh2o/densh2o
Vorg = VolMMA + VolDi
V = Volh2o + VolMMA + VolDi
Vinert = Volreactor-V  !mL
minert = (Po*Vinert*MMair)/(8314*Tamb)!g


!Initializing Yprimes
DO i=1,neq
	YPRIME(i)=0.0d0
ENDDO

WRITE(*,*) 'PRINTING Y OF YPRIME '
!Printing Y
!DO i=1,neq
	WRITE(*,*)'Y',i,'=', Y, '  YPRIME',i,'=', YPRIME 
!ENDDO
WRITE(*,*) ' '


CALL res(t,y,yprime,delta,ires,rpar,ipar)


!Printing deltas
WRITE(*,*) 'PRINTING DELTAS'
WRITE(*,*) ' '
DO i=1,neq
	WRITE(*,*)'delta',i,'=', delta(i)
ENDDO

WRITE(*,*) ' '
WRITE(*,*) 'INITIALIZING DASSL'
WRITE(*,*) ' '

!zeroing dassl
DO i=1,neq
	YPRIME(i)=-delta(i)
ENDDO
!Calling res subroutine
CALL res(t,y,yprime,delta,ires,rpar,ipar)


WRITE(*,*) 'PRINTING DELTAS'
WRITE(*,*) ' '
DO i=1,neq
	WRITE(*,*)'delta',i,'=', delta(i)
ENDDO

read(*,*)

!Defining DASSL parameters
!info(i) = 0  default.
DO i=1,15
   info(i)=0
ENDDO

!	*tolerances are now vectors
info(2)=1

!	Defining rtol e atol for the variables
DO i = 1, NEQ
   rtol(i) = 1.d-3 !1.d-3
   atol(i) = 1.d-3 !1.d-3
ENDDO
   
! Declaring the parameters regarding the integration:
! np     - number of integration points in time;
! tfinal - final integration time;
! dt     - step to advance in time; 
! tout   - final integration time, for each dt step 
!
dt = (tfinal-tini)/DBLE(np)
t  = tini
tout = dt

!write(*,*) 'oi', t, tout, dt
!pause


!Calling DASSL. 
DO i=1,np
   30 CALL ddassl(res,neq,t,y,yprime,tout,info,rtol,atol,idid,rwork,lrw,iwork,liw,rpar,ipar,jac)
   IF (idid<0) THEN
      WRITE(*,*) 'idid=',idid
      PAUSE
      STOP
      IF (idid.eq.-1) THEN
	     info(1)=0
	     GOTO 30
      ELSE
         WRITE(*,*)'end of execution - idid =',idid
         PAUSE
         STOP
      ENDIF
   ENDIF
   
   
   IPD = Mw/Mn 
   
 Conv=((y(5)+lambda_1)/(y(5)+lambda_1 +y(3)))*100 
     
WRITE(20,200) t, Press,Psath2o, PMMA, Pinert, Minert, Vinert
200 format(7(F13.6, 1x))
 

WRITE(10,100)  Press, Conv, IPD, Mn, Mw, Temp, Tc
!pause
100 format(7(F13.6, 1x))

WRITE(30,300) t, Temp,Tc
300 format(3(F13.6, 1x))


write(40,400) t, V, Volh2o, VolMMA, VolDi, Vinert, Volreactor
400 format(7(F13.6, 1x))

write(50,500) t, Y(1), Y(2), Y(3), Y(4), Y(5), LAMBDA_0, LAMBDA_1, LAMBDA_2
500 format(9(F13.6, 1x))

write (60,600) t
600 format (1(F13.6, 1x))

write (70,700) Press, IPD, Temp, Conv, Mn, Mw
700 format(6(F13.6, 1x))

write (80, 800) t, Press, Conv, IPD, Mn, Mw, Temp, Tc
800 format(8(F16.5, 1x))
   
   tout=tout+dt
ENDDO
!
   
CLOSE(10)
CLOSE(20)
CLOSE(30)
CLOSE(40)
CLOSE(50)
CLOSE(60)
CLOSE(70)
CLOSE(80)
write(*,*) 'kp', kp, 'ktm', ktm, 'ktd', ktd
pause

END PROGRAM