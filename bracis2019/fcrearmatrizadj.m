%..Fun��o para criar a matriz de adjacencia de um vetor
%..order = 'stable' ou nada

function [M,Vu]= fcrearmatrizadj(vector);

%[Vu,V,Vi] = unique_no_sort(vector);
[Vu,V,Vi] = unique(vector,'stable');   %..valores e indices �nicos del vector. Vu elementos �nicos (nomes), V �ndices dos �nicos em Vector, vecotor entrada com os nomes inteiros dos �nicos. 


       Lv = length(Vu);       %..cantidad de valores �nicos
        M = zeros(Lv,Lv);     %..matriz de adjacencia en ceros
       Li = length(Vi);       %..igual a length(vector)

for i=1:Li-1
    M(Vi(i),Vi(i+1)) = M(Vi(i),Vi(i+1)) + 1;
end

