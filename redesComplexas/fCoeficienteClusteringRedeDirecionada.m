%..Fun��o que devolve o coeficiente de clustering (Coe?ciente de
%aglomera��o) para grafos direcionados (d�grafo)
%..Entrada
%..M: Matriz de adjacencia (Com pessos ou sem pessos(binaria))
%..Saida
%..CD = [C CDa CDb CDc CDd];
%..C: clustering
%..CDa: clustering de triangulos tipo ciclo
%..CDb: clustering de triangulos tipo atravessador
%..CDc: clustering de triangulos tipo entrada
%..CDd: clustering de triangulos tipo saida

%..Exemplo
%..M = [0 2 3 0;0 0 0 3;0 1 0 3;0 0 4 0];
%..A = double(M>0);
% CD = fCoeficienteClusteringRedeDirecionada(M)
% CD = fCoeficienteClusteringRedeDirecionada(A)

function CD = fCoeficienteClusteringRedeDirecionada(M)

qW = length(find(M>1)); %..quantidade de arestas com peso >1

if qW>1 %..se � uma rede ponderada
    Wa = M.^(1/3); %..usar matriz de pessos simetrizadas
else
    Wa = M;     %..usar matriz de adjacencia
end

   A = double(M>0); %..Matriz de adjacencia (M~=0 d� logico)
Kout = sum(A,2);    %..grau de sa�da
 Kin = sum(A',2);   %..grau de entrada
Ktot = Kout + Kin;  %..grau total (in + out) 
  Kf = diag(A^2);   %..grau ao quadrado

  
%...Coeficiente com todos os triplos iguais................................
   numC = Wa + (Wa');          %..n�merador de C
numC = diag(numC^3);           %..n�mero de triangulos direcionados 
Ktot(numC==0) = inf;           %..se n�o existem triangulos faz C=0 (via Ktot=inf)
denC = Ktot.*(Ktot-1)-2*Kf;    %..n�mero total de possiveis triangulos 

C = (numC./denC)*(1/2);        %..coeficiente de clustering
%..........................................................................


%(a) cycle
numCDa = Wa^3;
numCDa = diag(numCDa);
denCDab = Kin.*Kout-Kf;
CDa = numCDa./denCDab;

%(b) middleman
numCDb = Wa * Wa' * Wa;
CDb = numCDa./denCDab;

%(c) in
numCDc = (Wa') * Wa^2;
numCDc = diag(numCDc);
denCDc = Kin.*(Kin-1);
CDc = numCDc./denCDc;

%(d) out
numCDd =  Wa^2 * (Wa');
numCDd = diag(numCDd);
denCDd = Kout.*(Kout-1);
CDd = numCDd./denCDd;

CD = [C CDa CDb CDc CDd];
%CD = [CD; mean(CD)];
%CD = [mean(CD)];
