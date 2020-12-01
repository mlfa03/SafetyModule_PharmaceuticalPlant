MODULE parameters

IMPLICIT NONE

REAL*8 :: Mn, Mw, Press, Temp, Tc
REAL*8 :: Dens_MMA, DensDi, VolMMA, VolDi, Minert, V, Vinert, Volh2o, Vorg, Mh2o
REAL*8 :: Psath2o, PMMA, Pinert,Ph2o
REAL*8 :: CONV, fvMMA, fvDi,cmi_0,cmi_1,cmi_2,lambda_0,lambda_1,lambda_2
REAL*8 :: kp, ktm, ktd, kd, gprop,gter
REAL*8 :: Vfmma, Vfpmma, Vf, Vftc, Vfpc
REAL*8 :: Cph2o, CpP,Rp,CpMMA,concM,concI, concH


INTEGER, PARAMETER :: Ni =8

INTEGER, PARAMETER :: neq  = 8
!INTEGER, PARAMETER :: Nr  = 4+2*Ni
INTEGER, PARAMETER :: liw=neq+20, lrw=40+9*neq+neq*neq               !dassl parametes
!ENERGY BALANCE PARAMETERS

REAL*8 :: R(NEQ)

REAL*8, PARAMETER :: densh2o  = 1.d0           !g/cm3  ou g/ml                
REAL*8, PARAMETER :: deltaHr = -13781.41      !cal/mol variation of reaction enthalpy 
REAL*8, PARAMETER :: UA      =  (1.997d-1)*7  ! initial estimative

!REAL*8, PARAMETER :: UA = 0 ! failure simulation of the heating and cooling of reactor's jacket 

REAL*8, PARAMETER :: UAa     =  (1.747d-2)*7 !cal/K.s             ! initial estimation
!REAL*8, PARAMETER :: Uaa = 0 
REAL*8, PARAMETER :: Vjacket =  3000 ! mL  
!REAL*8, PARAMETER :: Teci     = 363.15
!REAL*8, PARAMETER :: Tecf     = 300.15
REAL*8, PARAMETER :: Tec = 363.15            ! entry temperature of water in the jacket   

REAL*8, PARAMETER :: f       = 0.6d0         !efficiency factor 

 
!REAL*8, PARAMETER :: VolAg_inicial = 4.5d3 !mL
REAL*8, PARAMETER ::Fc = 170 !g/s 


!MOLECULAR WEIGHTS
REAL*8, PARAMETER :: MM_PVA = 86.09       
REAL*8, PARAMETER :: MM_Pbenz = 242.3d0    
REAL*8, PARAMETER :: MMh2o    = 18.d0        !g/mol   water molecular weight
REAL*8, PARAMETER :: MM_MMA  = 100.12       ! MMA molecular weight
REAL*8, PARAMETER :: MM_HQ = 110.11         ! inhibitor molecular weigth   
REAL*8, PARAMETER :: MMair    = 28.d0        !atmospheric air molecular weight
REAL*8, PARAMETER :: Po  = 101.325          !kPa 


REAL*8, PARAMETER :: X       = 0.5   
REAL*8, PARAMETER:: Rj = 8314               ! J/molK
REAL*8, PARAMETER :: Tamb = 298.15          ! ambient temperature in Kelvin
REAL*8, PARAMETER ::Volreator = 10000       !mL
!ATNOICE COEFFICIENTS: Ai, Bi, Ci   
REAL*8, PARAMETER:: Ah2o = 16.3872           !Antoine coefficients for water
REAL*8, PARAMETER:: Bh2o = 3885.70 
REAL*8, PARAMETER:: Ch2o = 230.170
REAL*8, PARAMETER:: Am  = 19.8567           !Antoine coefficients for MMA
REAL*8, PARAMETER:: Bm  = 5441.04
REAL*8, PARAMETER:: Cm  = 37.32



REAL*8, PARAMETER:: Rgases   = 1.987         !cal/(mol*K)
!fim of module
END MODULE




