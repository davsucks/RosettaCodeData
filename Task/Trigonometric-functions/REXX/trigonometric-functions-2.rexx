/*REXX program demonstrates some common trig functions (30 digits shown)*/
showdigs=30                            /*show only 30 digits of number. */
numeric digits showdigs+10             /*DIGITS default is  9,  but use */
                                       /*extra digs to prevent rounding.*/
say 'Using' showdigs 'decimal digits precision.';   say

  do j=-180  to +180  by 15            /*let's just do a half-Monty.    */
  stuff = right(j,4)       'degrees, rads='show( d2r(j)),
                                  '   sin='show(sinD(j)),
                                  '   cos='show(cosD(J))
                                            /*don't let  TAN  go postal.*/
  if abs(j)\==90 then stuff=stuff '   tan='show(tanD(j))
  say stuff
  end   /*j*/

say;      do k=-1  to +1  by 1/2       /*keep the  Arc-functions happy. */
          say right(k,4)   'radians, degs='show( r2d(k)),
                                  '  Acos='show(Acos(k)),
                                  '  Asin='show(Asin(k)),
                                  '  Atan='show(Atan(k))
          end   /*k*/
exit                                   /*stick a fork in it, we're done.*/
/*──────────────────────────────────subroutines─────────────────────────*/
Asin: procedure; parse arg x 1 z 1 o 1 p;  if x<-1 | x>1 then call AsinErr
      s=x*x;     if abs(x)>=sqrt(2)*.5  then return sign(x)*Acos(sqrt(1-s))
      do j=2 by 2; o=o*s*(j-1)/j; z=z+o/(j+1); if z=p then leave; p=z; end
      return z

Atan: procedure; parse arg x; if abs(x)=1 then return pi()*.25*sign(x)
                                               return Asin(x/sqrt(1+x*x))

cos: procedure; parse arg x; x=r2r(x); a=abs(x); numeric fuzz min(9,digits()-9)
                if a=pi() then return -1;  if a=pi()*.5 | a=pi()*2 then return 0
                pi3=pi()/3; if a=pi3 then return .5; if a=2*pi3 then return -.5
                return .sinCos(1,1,-1)

sin: procedure; parse arg x;  x=r2r(x);  numeric fuzz min(5,digits()-3)
                if abs(x)=pi()  then return 0;   return  .sinCos(x,x,1)

.sinCos: parse arg z 1 p,_,i;  x=x*x
         do k=2 by 2; _=-_*x/(k*(k+i));z=z+_;if z=p then leave;p=z;end; return z

sqrt: procedure; parse arg x; if x=0  then return 0;  m.=9; p=digits(); i=
numeric digits 9; if x<0  then do; x=-x; i='i'; end;  numeric form;  m.0=p
parse value format(x,2,1,,0) 'E0' with g 'E' _ .;     g=g*.5'E'_%2;  m.1=p
      do j=2  while p>9;      m.j=p;   p=p%2+1;                  end /*j*/
      do k=j+5  to 0  by -1;  numeric digits m.k; g=(g+x/g)*.5;  end /*k*/
                              numeric digits m.0;     return (g/1)i
e: return,
2.7182818284590452353602874713526624977572470936999595749669676277240766303535
           /*Note:  the actual E subroutine returns  E's  accuracy that */
           /*matches the current NUMERIC DIGITS, up to 1 million digits.*/
           /*If more than 1 million digits are required, be patient.    */

exp: procedure; parse arg x;  ix=x%1;  if abs(x-ix)>.5 then ix=ix+sign(x);  x=x-ix
     z=1; _=1; w=z;  do j=1;  _=_*x/j;  z=(z+_)/1;  if z==w then leave; w=z; end
     if z\==0 then z=e()**ix*z; return z

pi: return,                            /*a bit of overkill,  but hey !! */
3.1415926535897932384626433832795028841971693993751058209749445923078164062862
           /*Note:  the actual PI subroutine returns PI's accuracy that */
           /*matches the current NUMERIC DIGITS, up to 1 million digits.*/
           /*John Machin's formula is used for calculating more digits. */
           /*If more than 1 million digits are required, be patient.    */

Acos:  procedure; parse arg x; if x<-1|x>1 then call AcosErr; return .5*pi()-Asin(x)
AcosD: return r2d(Acos(arg(1)))
AsinD: return r2d(Asin(arg(1)))
cosD:  return cos(d2r(arg(1)))
sinD:  return sin(d2r(d2d(arg(1))))
tan:   procedure; parse arg x; _=cos(x); if _=0 then call tanErr; return sin(x)/_
tanD:  return tan(d2r(arg(1)))
d2d:   return arg(1)//360                /*normalize degrees►1 unit circle.  */
d2r:   return r2r(d2d(arg(1))*pi()/180)  /*convert   degrees ──► radians.    */
r2d:   return d2d((arg(1)*180/pi()))     /*convert   radians ──► degrees.    */
r2r:   return arg(1)//(pi()*2)           /*normalize radians ──►a unit circle*/
show:  return left(left('',arg(1)>=0)format(arg(1),,showdigs)/1,showdigs)
tellErr: say; say '*** error! ***'; say; say arg(1); say; exit 13
tanErr:  call tellErr 'tan('||x") causes division by zero, X="||x
AsinErr: call tellErr 'Asin(x),  X  must be in the range of  -1 ──► +1,  X='||x
AcosErr: call tellErr 'Acos(x),  X  must be in the range of  -1 ──► +1,  X='||x
sqrtErr: call tellErr "sqrt(x),  X  can't be negative,  X="||x
  /*  ┌───────────────────────────────────────────────────────────────┐
      │ Not included here are (among others):                         │
      │ some of the usual higher-math functions normally associated   │
      │  with trig functions:  POW, GAMMA, LGGAMMA, ERF, ERFC, ROOT,  │
      │                        LOG (LN), LOG2, LOG10, ATAN2,          │
      │ all of the hyperbolic trig functions and their inverses,      │
      │                                    (too many to name here).   │
      │ Angle conversions/normalizations: degrees/radians/grads/mils  │
      │ [a circle = 2 pi radians, 360 degrees, 400 grads,  6400 mils].│
      │ Some of the other trig functions are  (hyphens were added     │
      │ intentionally):                                               │
      │  CHORD                                                        │
      │  COT  (co-tangent)                                            │
      │  CSC  (co-secant)                                             │
      │  CVC  (co-versed cosine)                                      │
      │  CVS  (co-versed sine)                                        │
      │  CXS  (co-exsecant)                                           │
      │  HAC  (haver-cosine)                                          │
      │  HAV  (haver-sine                                             │
      │  SEC  (secant)                                                │
      │  VCS  (versed cosine or vercosine)                            │
      │  VSN  (versed sine   or versine)                              │
      │  XCS  (exsecant)                                              │
      │  COS/SIN/TAN cardinal  (damped  COS/SIN/TAN  function)        │
      │  COS/SIN     integral                                         │
      │    and all pertinent of the above's inverses (AVSN, ACVS...)  │
      └───────────────────────────────────────────────────────────────┘ */
