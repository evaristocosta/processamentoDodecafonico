%..fun��o que entra o vetor de classes de um classifica��o n�o
%supervisionado e compara com o vetor de classes ordenado, e calcula
%quantos elementos do grupo i de sa�da est�o dentro do grupo j de entrada
%isto � feito porque a numera��o dos grupos de entrada � diferentes �
%n�mera��o dos grupos de sa�da
%..se os dois grupos forem iguais ent�o os tamanos das classes ficam na
%diagonal principal
%..nomes: matriz que relaciona os n�mes de entrada com os de sa�da. 

%..sa�da
% Dif: erro quadr�tico m�dio dos tamanhos
% nomes: matriz de numclasses x 2, claase i,1 se chama classe i,2
% PorcAc: porcentagem de amostras no mesmo grupo
% TamanosMax: tamanho dos grupos
% M:  numeros das amostras na matriz de confus�o

% tamanhoClasses = [26 16 11]; 
% numClasses = size(tamanhoClasses,2);
% classes = [];
% for i=1:numClasses
%     classesi = zeros(tamanhoClasses(i),1) + i-1;
%     classes = [classes; classesi];
% end
% cSaida = classes+1; 
% [K,Dif,nomes] = fCompararClusterSaidaEntrada(cSaida,cSaida,3)

%..[K,Dif,nomes] = fCompararClusterSaidaEntrada([1 1 2 2 2 3 3 3 3],[1 1 2 2 2 3 3 3 3],3)

function [K,Dif,nomes,PorcAc,TamanosMax,M] = fCompararClusterSaidaEntrada(cEntrada,cSaida,c) 

%..ojo calcular c
if min(cEntrada)==0
    cEntrada = cEntrada + 1;
end
tamanhoClasses = zeros(1,c);
for i=1:c
 tamanhoClasses(1,i) = length(find(cEntrada==i));
end

 L = length(tamanhoClasses); %..n�mero de classes
 i2 = cumsum(tamanhoClasses); %..indice final
 i1 = [1 i2(1:end-1)+1];       %..indice inicial
 T = sum(tamanhoClasses);    %..total inst�ncias
 
 K = zeros(L,L);
 M = cell(L,L);
 for i=1:L
     k = find(cSaida==i);
     for j=1:L
         mG = ismember(k,i1(j):i2(j)); %..vetor bin�rio indicando se � membro
         M{i,j} = k(mG);               %..indices dos que s�o membros
         K(i,j) =  sum(mG);            %..total de membros do grupo
     end
 end

%[ValMax,IndMax] = fMaxRepetidos(K); %..valores dos m�ximos
%...achar a correspond�ncia entre o nome do grupo de entrada e o grupo de
%sa�da
[TamanosMax,nomesSaida] = fTotalGruposHierarquicosMatrizK(K);
                      B = sortrows(nomesSaida); %..ordenar por linhas para ficar de menor a maior

%|| (ismember(IndMax{i,1},IndMax{1:(i-1),1}))
%..ojo com estes casos: K = [1 0 0;25 15 11;0 1 0]; nomesSaida= [1 1 2];
%repete 1 porque na linha 1 o �nico m�ximo � 1 e o m�ximo da segunda linha
%est� em 1, mas o m�ximo de 3 est� en 2, teria que mandar o m�ximo da
%segunda linha para a terceira coluna - a sa�da boa seria [1 3 2]

     V = [tamanhoClasses(B(:,1))' TamanosMax(B(:,2))]; %..vetor com os tamanos de entrada e sa�da
   Dif = sum((V(:,1)-V(:,2)).^2)/c;                    %..erro quadr�tico m�dio dos tamanhos
 nomes = B;                                            %..nomes dos grupos na entrada e o nome dado pelo clustering

 PorcAc = (V(:,2)./V(:,1))*100; %..porcentagem de amostras no mesmo grupo
 PorcAc =  PorcAc';
 
 for i=1:c
    if PorcAc(i)>100
        PorcAc(i) = 100;
    else
        PorcAc(i) = PorcAc(i);
    end
 end
 
 TamanosMax = V(:,2)';
 
 K = K(B(:,2),:);  %..K com as linhas ordenadas 
 M = M(B(:,2),:); %..trocar as linhas 
%..Matriz K
%  linhas Num. do grupo de sa�da i
%  Colunas Total elementos do grupo pertencem ao grupo de sa�da de entrada j

%[TamanosMax,nomesSaida] = max(K,[],2); %..m�ximos por linha, devolve vetor
%coluna - TamanosMax=valor do m�x, nomesSaida=indice da primeira ocorr�ncia
%do m�x.







