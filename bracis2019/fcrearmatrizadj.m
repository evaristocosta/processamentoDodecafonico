%..Função para criar a matriz de adjacencia de um vetor
%..order = 'stable' ou nada

function [M,Vu]= fcrearmatrizadj(vector);

%[Vu,V,Vi] = unique_no_sort(vector);
[Vu,V,Vi] = unique(vector,'stable');   %..valores e indices únicos del vector. Vu elementos únicos (nomes), V índices dos únicos em Vector, vecotor entrada com os nomes inteiros dos únicos. 


       Lv = length(Vu);       %..cantidad de valores únicos
        M = zeros(Lv,Lv);     %..matriz de adjacencia en ceros
       Li = length(Vi);       %..igual a length(vector)

for i=1:Li-1
    M(Vi(i),Vi(i+1)) = M(Vi(i),Vi(i+1)) + 1;
end

