%..intervalo mayor y menor
%..intervalos ascendente mayor y descendente mayor

%..vector de notas escalado a una octava
%P=[2 4 3 7 6 9 9 12 4 6 6 7 4 9];


function [Imayorasc,Imayordesc]=intervalomayormenor(I);

%..Se extrae la columna de Pitch
%P=mod(pitch(nmat)',12);

n=length(I)+1;
%I=intervalos(P);

[Iasc,Iconst,Idesc]=discriminterv(I);


Imayorasc=max(Iasc);    %..mayor intervalos ascendente
Imayordesc=min(Idesc);  %..mayor intervalo descendente

