function [intr_asc,intr_dsc] = intervalos_maior_menor(x)
n=length(x);
I=intervalos(x);

[Iasc,Iconst,Idesc]=discriminterv(I);


intr_asc=max(Iasc);    %..mayor intervalos ascendente
intr_dsc=min(Idesc);  %..mayor intervalo descendente

