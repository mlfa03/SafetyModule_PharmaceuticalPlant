SUBROUTINE variaveis(y)



USE parametros

IMPLICIT NONE

REAL(8), INTENT (IN)  :: y(8)     !variaveis de entrada

Temp = y(7) 
Tc = y(8)


dens_MMA = 9.654d-1 - 1.09d-3*(Temp-273.15)-9.7d-7*((Temp-273.15)**2) !g/cm3 
densDi = dens_MMA/(0.754 - 9.d-4*(Temp-343.15))
VolMMA  = y(3)*MM_MMA/dens_MMA  !mL
VolDi  = y(5)*MM_MMA/densDi
V = VolAg + VolMMA + VolDi
Vorg = VolMMA + VolDi
Vinerte = Volreator-V  

cmi_0 = y(4)/Vorg
cmi_1 = y(5)/Vorg
cmi_2 = y(6)/Vorg  

IF(Y(1).gt.0.d0) THEN
concI    = y(1)/Vorg
ELSE
concI    = 0.d0
ENDIF

concH = y(2)/Vorg


IF(Y(3).gt.0.d0) THEN
ConcM    = y(3)/Vorg
ELSE
ConcM    = 0.d0
ENDIF


!EFEITO GEL
!Volumes livres em função da temperatura 
Vfmma = 2.5d-2 + 1d-3*(Temp - 167.d0)!Vfmma = 0.025 + 0.001*(Temp - 167) 
Vfpmma = 2.5d-2 + 4.8d-4*(Temp-387.d0)

!X = VmolarH20*(s1-s2)*(s1-s2)/R*T
fvMMA = VolMMA/(Vorg)
fvDi = VolDi/(Vorg)

Vf = Vfmma*fvmma + Vfpmma*fvDi        !Volume livre total
write(*,*) ' Volume Livre', VfMMA, fvMMA, VfPMMA, fvDi, Vf
!pause


Vftc = 1.856d-1 - 2.965d-4*(Temp-273.15d0)! Volume livre critico para a terminação
Vfpc = 5.d-2                           ! Volume livre crítico para a propagação

!Influência do efeito gel na constante de terminação
IF (Vf.gt.Vftc) THEN 
  gter = 1.0575d-1 * dexp(17.5*Vf - 1.1715d-2*(Temp-273.15d0))
  ELSE
  gter = 2.3d-6*dexp(75*Vf)
ENDIF 


 !Influência do efeito gel na constante de propagação
IF (Vf.gt.Vfpc) THEN
  gprop = 1
  ELSE
  gprop = 7.1d-5*dexp(171.53*Vf)
ENDIF



!CONSTANTES CINÉTICAS
kd  =  1.7d14*dexp(-30000.d0/(Rgases*Temp)) !1/s
kp  = (7.d9*dexp((-6300)/(Rgases*Temp)))*gprop !cm^3/mol.s
ktd = (1.76d12*dexp((-2800)/(Rgases*Temp)))*gter
!write(*,*) 'kp', kp, 'ktd', ktd
!pause


!IF (Temp.ge.50.and.Temp.le.80) THEN      ! 50 <= Temp <=80
  IF (Temp.ge.323.15.and.Temp.le.353.15) THEN
  ktm = kp*dexp(-2.6 - (2855.d0/Temp))  
ENDIF

!ktm = 1.d-11 

write(*,*)'constantes cineticas', kd,kp, ktd,concM
!pause

 CpAg = 1.00  !cal/g.K
 CpP  = 0.339 + 9.55d-4*(Temp - 298.15)  !cal/g.K
 CpMMA= 0.490 !cal/g.K
 
!write (*,*) 'cp' ,cpAg,cpMMA,cpP


 END SUBROUTINE