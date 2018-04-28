%..função que entra o vetor de classes de um classificação não
%supervisionado e compara com o vetor de classes ordenado, e calcula
%quantos elementos do grupo i de saída estão dentro do grupo j de entrada
%isto é feito porque a numeração dos grupos de entrada é diferentes à
%númeração dos grupos de saída
%..se os dois grupos forem iguais então os tamanos das classes ficam na
%diagonal principal
%..nomes: matriz que relaciona os nómes de entrada com os de saída. 

%..saída
% Dif: erro quadrático médio dos tamanhos
% nomes: matriz de numclasses x 2, claase i,1 se chama classe i,2
% PorcAc: porcentagem de amostras no mesmo grupo
% TamanosMax: tamanho dos grupos
% M:  numeros das amostras na matriz de confusão

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

 L = length(tamanhoClasses); %..número de classes
 i2 = cumsum(tamanhoClasses); %..indice final
 i1 = [1 i2(1:end-1)+1];       %..indice inicial
 T = sum(tamanhoClasses);    %..total instâncias
 
 K = zeros(L,L);
 M = cell(L,L);
 for i=1:L
     k = find(cSaida==i);
     for j=1:L
         mG = ismember(k,i1(j):i2(j)); %..vetor binário indicando se é membro
         M{i,j} = k(mG);               %..indices dos que são membros
         K(i,j) =  sum(mG);            %..total de membros do grupo
     end
 end

%[ValMax,IndMax] = fMaxRepetidos(K); %..valores dos máximos
%...achar a correspondência entre o nome do grupo de entrada e o grupo de
%saída
[TamanosMax,nomesSaida] = fTotalGruposHierarquicosMatrizK(K);
                      B = sortrows(nomesSaida); %..ordenar por linhas para ficar de menor a maior

%|| (ismember(IndMax{i,1},IndMax{1:(i-1),1}))
%..ojo com estes casos: K = [1 0 0;25 15 11;0 1 0]; nomesSaida= [1 1 2];
%repete 1 porque na linha 1 o único máximo é 1 e o máximo da segunda linha
%está em 1, mas o máximo de 3 está en 2, teria que mandar o máximo da
%segunda linha para a terceira coluna - a saída boa seria [1 3 2]

     V = [tamanhoClasses(B(:,1))' TamanosMax(B(:,2))]; %..vetor com os tamanos de entrada e saída
   Dif = sum((V(:,1)-V(:,2)).^2)/c;                    %..erro quadrático médio dos tamanhos
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
%  linhas Num. do grupo de saída i
%  Colunas Total elementos do grupo pertencem ao grupo de saída de entrada j

%[TamanosMax,nomesSaida] = max(K,[],2); %..máximos por linha, devolve vetor
%coluna - TamanosMax=valor do máx, nomesSaida=indice da primeira ocorrência
%do máx.







