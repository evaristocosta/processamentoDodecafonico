%..algoritmo de floyd-warshall
%..M: matriz de adjacencia, p: n�mero de pasos
%..ComAutoconexoes: 1 usa a diag. ppal, 0 n�o usa

function [DW,DB,DWB] = floydwarshall(M,p)

%..Matriz de dist�ncias ponderadas.........................................
[fM,cM] = size(M);
M1 = zeros2inf(M);
M1(1:fM+1:end) = 0;
DW = M1; 
for k=1:p
    for i=1:fM
        for j=1:cM
            DW(i,j) = min(M1(i,j),M1(i,k)+M1(k,j));
        end
        M1 = DW;
    end
end
%..........................................................................


%..Matriz de dist�ncias bin�rias...........................................
    A = double(M~=0);  %...matriz bin�ria
    l = 1;             %..comprimento do caminho
Lpath = A;             %..matriz de caminhos
   DB = A;             %..matriz de dist�ncias

Idx = true;
while any(Idx(:))
         l = l+1;
     Lpath = Lpath*A;
       Idx = (Lpath~=0)&(DB==0);
   DB(Idx) = l;
end

DB(~DB) = inf;       %assign inf to disconnected nodes
DB(1:length(A)+1:end) = 0;         %clear diagonal
%..........................................................................

%..Matriz dist�ncias somatoria pesos/num arestas

DWB = DW./DB; %..ojo inf/inf da NaN, arrumei para Inf
DWB(DB==Inf)= Inf;
DWB(1:fM+1:end) = 0;
%........................................................................
  

%..diagonal principal en ceros
% for i=1:length(M1)
%     M1(i,i) = 0;
% end
%..M1(1:fM+1:end) = 0; � m�s r�pido


