%...discriminación de intervalos
%...separa los intervalos ascendentes, descendentes e iguales.
%..devuelve 3 vectores con los intervalos separados

function [Iasc,Iconst,Idesc]=discriminterv(I);

n=length(I);

Iasc=0;   a=1;
Iconst=0; g=1;
Idesc=0;  d=1;

for i=1:n
    if I(1,i)>0
        Iasc(1,a)=I(1,i);
        a=a+1;
    else
        if I(1,i)==0
          Iconst(1,g)=I(1,i);
          g=g+1;
        else
          Idesc(1,d)=I(1,i);
          d=d+1;
        end
    end
end