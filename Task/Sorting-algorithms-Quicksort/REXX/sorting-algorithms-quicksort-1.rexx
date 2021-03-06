/*REXX program  sorts  a stemmed array using the   quicksort   method.  */
call gen@                              /*generate the array elements.   */
call show@ 'before sort'               /*show   before   array elements.*/
call quickSort highItem                /*here come da judge, here come..*/
call show@ ' after sort'               /*show    after   array elements.*/
exit                                   /*stick a fork in it, we're done.*/
/*──────────────────────────────────QUICKSORT subroutine────────────────*/
quickSort: procedure expose @.         /*access the caller's local var. */
a.1=1;   b.1=arg(1);   $=1

  do while $\==0;   l=a.$;   t=b.$;   $=$-1
  if t<2  then iterate
  h=l+t-1
  ?=l+t%2
  if @.h<@.l then if @.?<@.h then do; p=@.h; @.h=@.l; end
                             else if @.?>@.l then p=@.l
                                             else do; p=@.?; @.?=@.l; end
             else if @.?<@.l then p=@.l
                             else if @.?>@.h then do; p=@.h; @.h=@.l; end
                                             else do; p=@.?; @.?=@.l; end
  j=l+1
  k=h
        do forever
            do j=j       while j<=k & @.j<=p; end    /*a tinie-tiny loop*/
            do k=k by -1 while j <k & @.k>=p; end    /*another tiny loop*/
        if j>=k  then leave
        _=@.j; @.j=@.k; @.k=_
        end   /*forever*/

  k=j-1;  @.l=@.k;  @.k=p
  $=$+1
  if j<=?  then do;  a.$=j;  b.$=h-j+1;  $=$+1;  a.$=l;  b.$=k-l;     end
           else do;  a.$=l;  b.$=k-l;    $=$+1;  a.$=j;  b.$=h-j+1;   end
  end   /*while $\==0*/

return
/*──────────────────────────────────GEN@ subroutine─────────────────────*/
gen@:  @.=;   maxL=0                   /*assign default value for array.*/
@.1 =" Rivers that form part of a state's (USA) border "   /*adj. later,*/
@.2 ='='                               /*this value is expanded later.  */
@.3 ="Perdido River:                      Alabama, Florida"
@.4 ="Chattahoochee River:                Alabama, Georgia"
@.5 ="Tennessee River:                    Alabama, Kentucky, Mississippi, Tennessee"
@.6 ="Colorado River:                     Arizona, California, Nevada, Baja California (Mexico)"
@.7 ="Mississippi River:                  Arkansas, Illinois, Iowa, Kentucky, Minnesota, Mississippi, Missouri, Tennesse, Louisiana, Wisconsin"
@.8 ="St. Francis River:                  Arkansas, Missouri"
@.9 ="Poteau River:                       Arkansas, Oklahoma"
@.10="Arkansas River:                     Arkansas, Oklahoma"
@.11="Red River (Mississippi watershed):  Arkansas, Oklahoma, Texas"
@.12="Byram River:                        Connecticut, New York"
@.13="Pawcatuck River:                    Connecticut, Rhode Island"
@.14="Delaware River:                     Delaware, New Jersey, New York, Pennsylvania"
@.15="Potomac River:                      District of Columbia, Maryland, Virginia, West Virginia"
@.16="St. Marys River:                    Florida, Georgia"
@.17="Chattooga River:                    Georgia, South Carolina"
@.18="Tugaloo River:                      Georgia, South Carolina"
@.19="Savannah River:                     Georgia, South Carolina"
@.20="Snake River:                        Idaho, Oregon, Washington"
@.21="Wabash River:                       Illinois, Indiana"
@.22="Ohio River:                         Illinois, Indiana, Kentucky, Ohio, West Virginia"
@.23="Great Miami River (mouth only):     Indiana, Ohio"
@.24="Des Moines River:                   Iowa, Missouri"
@.25="Big Sioux River:                    Iowa, South Dakota"
@.26="Missouri River:                     Kansas, Iowa, Missouri, Nebraska, South Dakota"
@.27="Tug Fork River:                     Kentucky, Virginia, West Virginia"
@.28="Big Sandy River:                    Kentucky, West Virginia"
@.29="Pearl River:                        Louisiana, Mississippi"
@.30="Sabine River:                       Louisiana, Texas"
@.31="Monument Creek:                     Maine, New Brunswick (Canda)"
@.32="St. Croix River:                    Maine, New Brunswick (Canda)"
@.33="Piscataqua River:                   Maine, New Hampshire"
@.34="St. Francis River:                  Maine, Quebec (Canada)"
@.35="St. John River:                     Maine, Quebec (Canada)"
@.36="Pocomoke River:                     Maryland, Virginia"
@.37="Palmer River:                       Massachusetts, Rhode Island"
@.38="Runnins River:                      Massachusetts, Rhode Island"
@.39="Montreal River:                     Michigan (upper peninsula), Wisconsin"
@.40="Detroit River:                      Michigan, Ontario (Canada)"
@.41="St. Clair River:                    Michigan, Ontario (Canada)"
@.42="St. Marys River:                    Michigan, Ontario (Canada)"
@.43="Brule River:                        Michigan, Wisconsin"
@.44="Menominee River:                    Michigan, Wisconsin"
@.45="Red River of the North:             Minnesota, North Dakota"
@.46="Bois de Sioux River:                Minnesota, North Dakota, South Dakota"
@.47="Pigeon River:                       Minnesota, Ontario (Canada)"
@.48="Rainy River:                        Minnesota, Ontario (Canada)"
@.49="St. Croix River:                    Minnesota, Wisconsin"
@.50="St. Louis River:                    Minnesota, Wisconsin"
@.51="Halls Stream:                       New Hampshire, Canada"
@.52="Salmon Falls River:                 New Hampshire, Maine"
@.53="Connecticut River:                  New Hampshire, Vermont"
@.54="Arthur Kill:                        New Jersey, New York (tidal strait)"
@.55="Kill Van Kull:                      New Jersey, New York (tidal strait)"
@.56="Hudson River (lower part only):     New Jersey, New York"
@.57="Rio Grande:                         New Mexico, Texas, Tamaulipas (Mexico), Nuevo Leon (Mexico), Coahuila De Zaragoza (Mexico), Chihuahua (Mexico)"
@.58="Niagara River:                      New York, Ontario (Canada)"
@.59="St. Lawrence River:                 New York, Ontario (Canada)"
@.60="Poultney River:                     New York, Vermont"
@.61="Catawba River:                      North Carolina, South Carolina"
@.62="Blackwater River:                   North Carolina, Virginia"
@.63="Columbia River:                     Oregon, Washington"

  do highItem=1  while @.highItem\=='' /*find how many entries, and also*/
  maxL=max(maxL,length(@.highItem))    /*  find the maximum width entry.*/
  end   /*highItem*/

highItem=highItem-1                    /*adjust highItem slightly.      */
@.1=centre(@.1,maxL,'-')               /*adjust the header information. */
@.2=copies(@.2,maxL)                   /*adjust the header separator.   */
return
/*──────────────────────────────────SHOW@ subroutine────────────────────*/
show@: widthH=length(highItem)         /*maximum width of any line.     */

                  do j=1 for highItem  /*display each item in the array.*/
                  say  'element'    right(j,widthH)    arg(1)':'    @.j
                  end   /*j*/

say copies('█',maxL+widthH+22)         /*display a  separator  line.    */
return
