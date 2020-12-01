SUBROUTINE bal_massa(y)

USE parametros

IMPLICIT NONE
REAL(8), INTENT(IN)::Y(8)


!Mass balance of the initiator
R(1)= -2*kd*concI*Vorg

!Mass balance of the inhibitor
R(2)=-2*f*kd*concI*Vorg
!
!lambda_0 balance

IF(Y(2).gt.0.d0) THEN
lambda_0 = 0
lambda_1 = 0
lambda_2 = 0
ELSE
lambda_0    = (sqrt(2*f*kd*concI*Vorg**2/ktd))
if (lambda_0 .gt.0.d0) then
    lambda_1 = (2*f*kd*concI+ktm*concM*(lambda_0/Vorg) + kp*concM*(lambda_0/Vorg))*Vorg/(ktm*concM + ktd*(lambda_0/Vorg))
    lambda_2 = (2*f*kd*concI+ktm*concM*(lambda_0/Vorg) + 2*kp*concM*(lambda_1/Vorg) + kp*concM*(lambda_0/Vorg))*Vorg/(ktd*(lambda_0/Vorg)+ ktm*concM)
    else
    lambda_1=0.0d0
    lambda_2=0.0d0
    endif    
ENDIF


!Monomer Balance
IF( (Y(3).gt.0.D0) .and. (Y(2).le.0.D0) )THEN
R(3)=(2*f*kd*concI -kp*ConcM*(lambda_0/Vorg) - ktm*ConcM*(lambda_0/Vorg))*Vorg
ELSE
R(3)=0.d0
ENDIF

write(*,*) 'R3' , R(3)
!pause


! mi_0 balance
R(4)=(ktd*(lambda_0/Vorg)*(lambda_0/Vorg)+ktm*concM*(lambda_0/Vorg))*Vorg !mi_0

!mi_1 balance
R(5)=(ktd*(lambda_0/Vorg)*(lambda_1/Vorg)+ktm*concM*(lambda_1/Vorg))*Vorg !mi_1

!mi_2 balance
R(6)=(ktd*(lambda_0/Vorg)*(lambda_2/Vorg)+ktm*concM*(lambda_2/Vorg))*Vorg   !mi_2


RETURN
END SUBROUTINE

!jacobian matrix
SUBROUTINE jac (t,y,yprime,pd,cj,rpar,ipar)

USE parametros

IMPLICIT NONE

!	Declaring the variables
!	*jac
REAL*8 :: cj, t
INTEGER, DIMENSION(neq) :: ipar
REAL*8, DIMENSION(neq) :: rpar
REAL*8, DIMENSION(neq,neq) :: pd
REAL*8, DIMENSION(neq) ::yprime, delta,y
!REAL*8 DIMENSION(8)::y
RETURN
!	end of jac subroutine
END SUBROUTINE





