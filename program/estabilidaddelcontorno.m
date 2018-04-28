function [EC,ECP,ECN]=estabilidaddelcontorno(nmat);
  P = nmat;
  I=diff(P);
  ni=length(I);

  %..Cantidad de intervalos 
  gip=0; gin=0;
  for i=1:ni-1
      if (I(1,i)>0) && ((I(1,i+1)>0))
          gip=gip+1;
      else
          if (I(1,i)<0) && ((I(1,i+1)<0))
              gin=gin+1;
          end
      end
  end
  gip; %..cantidad de 2 o m�s intervalos positivos seguidos 
  gin; %..cantidad de 2 o m�s intervalos negativos seguidos 
  %........................................

  %..Calcular el descriptor..................
  ECP= gip /(ni-1);  %..proporci�n de intervalos positivos seguidos - v.altos sube r�pido
  ECN= gin /(ni-1);  %..proporci�n de intervalos negativos seguidos -         baja r�pido

  EC=(gip+gin)/ni; %..Proporci�n de intervalos en igual direcci�n segudios
  %..........................................
end