SUBROUTINE pressure(y)

USE parameters
IMPLICIT NONE
!Declaring variables
REAL(8), INTENT (IN)  :: y(8)     !entry variables
REAL*8::PsatMMA


Mn = (y(5))/(y(4))*MM_MMA 
Mw = (y(6))/(y(5))*MM_MMA
   
!Antoine equations to calculate Psat
Psath2o = dexp(Ah2o - (Bh2o)/(Temp-273.15 + Ch2o))  
PsatMMA =  (dexp((Am - (Bm)/((Temp) + Cm))))*1.33d-1
Pinert = (minert*8314*Temp)/(MMair*Vinert)
PMMA = dexp(log(PsatMMA) + log(fvMMA) + (X*(fvDi)**2))


Press     = Psath2o + PMMA + Pinert

END SUBROUTINE