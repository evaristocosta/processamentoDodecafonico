%...Variedad tonal descriptor #1
%...
%...Prog: Andrés Eduardo Coca S.
%...Date: 17.01.09 11:30 am

%...vector de notas....
%P=[1 2 2 3 4 5 6 7 8 9 10 12 11 12 12 12 16 11 1 10 10 9 7 6 6 5 6 7 7 7 8 9];
%P=[2 2 2 2 2 2 2 2 3 3 6];

function VT = variedadtonal(nmat);

%..Se extrae la columna de Pitch
P = mod(pitch(nmat)',12); 

%..Obtener la longitud, el máxim, el mínimo.+
  n = length(P);
inf = min(P);
sup = max(P);

%..cuenta el número de veces que está cada valor
%..el tamaño de V es el número de valores diferentes
V = histc(P,inf:sup);
 
%..quitarle los ceros.........
lv = length(V);
 k = 1;
for i=1:lv
    if V(1,i)>0
        V1(1,k)=V(1,i);
        k=k+1;
    end
end
%..............................

%..número de valores diferentes...
ndif=length(V1);
%.................................

%..Se halla el descriptor......
VT=ndif/n;
%..............................






