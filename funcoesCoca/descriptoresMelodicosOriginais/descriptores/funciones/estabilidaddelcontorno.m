%..estabilidad del contorno
%..densidad de grupos de intervalos en la misma dirección 
%..a. cantidad de grupos de intervalos positivos seguidos
%..b.                                  negativos seguidos
%..c.                                  iguales +/- seguidos

%Ejemplos
%..vector de notas escalado a una octava
%P=[2 4 4 5 7 8 7 9 9 9 12 0 9 9 9 8 7 6 4 3];
%P=[2 2 2 2 2 6 7 4 2 2 2 2 2];
%P=[1 2 3 4 5 6 7 8 9 10];
%P=[10 9 8 7 6 5 4 3 2 1];
%P=[2  2 2 2 2 2 2 2 2 2];
%I=[ 2   1   2  -1  3  0   3   -3  -1 -1 -1 -2 5];

function [EC,ECP,ECN,ECC]=estabilidaddelcontorno(nmat);

%..Se extrae la columna de Pitch
P = mod(pitch(nmat),12)';

I=intervalos(P);
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
%..........................................