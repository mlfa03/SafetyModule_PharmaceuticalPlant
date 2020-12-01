!Resiudes calculation
SUBROUTINE res(t,y,yprime,delta,ires,rpar,ipar)

USE parameters
IMPLICIT NONE
!Declaring the variables
!*res
REAL*8  :: t
INTEGER :: ires,i
!*dassl
INTEGER, DIMENSION(neq) :: ipar
REAL*8, DIMENSION(neq) :: rpar
REAL*8, DIMENSION(neq) :: yprime, delta
!Variaveis auxiliares
INTEGER aux1, aux2
REAL*8, DIMENSION(neq) ::y

CALL variables(y)
CALL mass_bal(y)
CALL pressure(y)

R(7)= (R(3)*(deltaHr)- UA*(Temp-Tc)-UAa*(Temp-Tamb))/(y(3)*MM_MMA*CpMMA + y(5)*MM_MMA*CpP + Mh2o*Cph2o) ! dT/dt

R(8) = (UA*(Temp-Tc)+Fc*Cph2o*(Tec-Tc)-UAa*(Tc-Tamb))/(CpAg*densh2o*Vjacket)



DELTA(1) = YPRIME(1) - R(1)   !initiator 

IF(Y(2).gt.0.d0) THEN
delta(2) = yprime(2)-R(2) ! inhibitor
ELSE
delta(2) = yprime(2)
ENDIF


DELTA(3) = YPRIME(3) - R(3)    !
DELTA(4) = YPRIME(4) - R(4)    !
DELTA(5) = YPRIME(5) - R(5)
DELTA(6) = YPRIME(6) - R(6)
DELTA(7) = YPRIME(7) - R(7)
DELTA(8) = YPRIME(8) - R(8)

RETURN

END SUBROUTINE