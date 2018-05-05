function [accuracy,c,K,cSaida,mPA] = HierarquicoNS(dist, agr, medidasR, classes)
%Medida de dist�ncia e m�todo de agrupamento
MDist = {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'};
MAgru = {'single','complete','average','weighted','centroid','median','ward'};

tamanhoClasses = [19 19]; 
numClasses = size(tamanhoClasses,2);

%[medidasR, classes] = medidas();
NumClasses = max(classes) + 1;

[cSaida,Z,c,I,Te] = fClusteringHierarquico(medidasR,NumClasses,MDist{dist},MAgru{agr},1); %..e grafica 0 ou 1, ultimo par�metro
CoefCophenetic(1,1) = c;
MaxNumClasses(1,:) = fVetorClasse2VetorTamanhoClasse(cSaida);  %..tamanho de cada grupo
[K,EQMT(1,1),nomes,PA(1,:),TamGrup(1,:),M] = fCompararClusterSaidaEntrada(classes,cSaida,numClasses); %..matriz de confus�o: Erro quadratico m�dio, nomes certos, Acc por classe, tamanho classes,amostras da matriz de confus�o,
cSaida = fTrocarNomesVetorClasses(cSaida,nomes); %..trocar os nomes de um vetor de classes segundo os nomes da tabela nomes
mPA = mean(PA,2); %..accur�cia m�dia
[maxPA,ImaxPA] = max(mPA); %..�ndice da classe com a m�x acur�cia

[accuracy,medidasD] = fMedidasMatrizConfusaoMulticlasse(K); %..acu�ria e taxas de desempenho
end