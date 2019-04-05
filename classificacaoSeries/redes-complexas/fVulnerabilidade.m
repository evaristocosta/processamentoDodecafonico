%..Função que calcula a vulnerabilidade de uma rede

% M = sparse([1 1 2 2 2 3 3 3 4 4 4 4 5 5 5 6 6 6 7 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14], [2 3 1 3 4 2 1 4 2 3 7 14 6 7 8 5 7 9 4 5 6 8 9 5 7 9 13 6 7 8 12 11 12 13 14 10 13 9 10 13 14 8 10 11 12 4 10 12], 1);
% [V,EGi] = fVulnerabilidade(M)

function [V,Vi,EGi] = fVulnerabilidade(M)

 N = length(M);                     %..número de nós
 D = inf2zero(floydwarshall(M,N));  %..matriz de distâncias mínimas
EG = fEficienciaGlobal(D);          %..eficência global

for i=1:N
    Mi = M;        %..copiar a matriz 
    Mi(i,:) = [];  %..apagar o nó i
    Mi(:,i) = [];
         Di = inf2zero(floydwarshall(Mi,N-1)); %..nova matriz de distâncias
        EGi(i) = fEficienciaGlobal(Di);        %..nova Eficiência global
       Vi(i) = (EG-EGi(i))/EG;                 %..vulnerabilidade do no i
end

V = max(Vi);  %..vulnerabilidade total
