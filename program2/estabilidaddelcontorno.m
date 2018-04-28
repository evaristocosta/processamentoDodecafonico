function [EC,ECP,ECN]=estabilidaddelcontorno(nmat);
  P = nmat;
  I=diff(P);
  ni=length(I);

  %Cantidad de intervalos 
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
  gip; %..cantidad de 2 o mas intervalos positivos seguidos 
  gin; %..cantidad de 2 o mas intervalos negativos seguidos 
  %........................................

  %..Calcular el descriptor..................
  ECP= gip /(ni-1);  %..proporcion de intervalos positivos seguidos - v.altos sube rapido
  ECN= gin /(ni-1);  %..proporcion de intervalos negativos seguidos -         baja rapido

  EC=(gip+gin)/ni; %..Proporcion de intervalos en igual direccion segudios
  %..........................................
end