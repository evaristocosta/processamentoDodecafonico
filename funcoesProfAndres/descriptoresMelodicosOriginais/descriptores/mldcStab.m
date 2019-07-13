function [EC,ECP,ECN,ECC]=mldcStab(x)

I=intervalos(x);
ni=length(I);

%..Cantidad de intervalos positivos.........
gip=0; gin=0; gic=0;
for i=1:ni-1
    if (I(1,i)>0) && ((I(1,i+1)>0))
        gip=gip+1;
    else
        if (I(1,i)<0) && ((I(1,i+1)<0))
            gin=gin+1;
        else
            if (I(1,i)==0) && ((I(1,i+1)==0))
                gic=gic+1;
            end
        end
    end
end
gip; %..cantidad de 2 o más intervalos positivos seguidos 
gin; %..cantidad de 2 o más intervalos negativos seguidos 
gic; %..cantidad de 2 o más unísonos seguidos
%........................................

%..Calcular el descriptor..................
ECP= gip /(ni-1);  %..proporción de intervalos positivos seguidos - v.altos sube rápido
ECN= gin /(ni-1);  %..proporción de intervalos negativos seguidos -         baja rápido
ECC= gic /(ni-1);  %..proporción de unísonos seguidos             -         no sube           

EC=(gip+gin+gic)/ni; %..Proporción de intervalos en igual dirección segudios