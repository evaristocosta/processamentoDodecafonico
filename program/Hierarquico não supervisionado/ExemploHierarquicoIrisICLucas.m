function [accuracy,medidasD,cSaida,K,EQMT,maxPA,ImaxPA,mPA] = ExemploHierarquicoIrisICLucas(meas)
%..iris data: https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
%load fisheriris.mat

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'numeric');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'evaristo', '746136', 'Vendor', 'POSTGRESQL', 'Server', 'localhost', 'PortNumber', 5432);

%Read data from database.
curs = exec(conn, ['SELECT 	measures.id'...
    ' ,	measures.ec'...
    ' ,	measures.ecp'...
    ' ,	measures.ecn'...
    ' ,	measures.mpp'...
    ' ,	measures.dca'...
    ' ,	measures.dcd'...
    ' FROM 	"dodecaf"."public".measures ']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
medidasR = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn


%medidasR = meas;

tamanhoClasses = [36 36 36]; 
%..........................Vetor de classes................................
totalEstancia = sum(tamanhoClasses);
numClasses = size(tamanhoClasses,2);
classes = [];
for i=1:numClasses
    classesi = zeros(tamanhoClasses(i),1) + i-1;
    classes = [classes; classesi];
end
NumClasses = max(classes) + 1;
%..........................................................................


%............Medida de dist�ncia e m�todo de agrupamento...................
% MDist = {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'}; %..tirei  'mahalanobis',
% MAgru = {'single','complete','average','weighted','centroid','median','ward'};
MDist = {'cosine'};  %..tirei 'mahalanobis',
MAgru = {'average'}; %MAgru = {'complete','average','ward'};

L1 = length(MDist);
L2 = length(MAgru);
%..........................................................................

%...classificar n�o supervisionado - hierarquico
kkk = 1;
[cSaida,Z,c,I] = fClusteringHierarquico(medidasR,NumClasses,MDist{1},MAgru{1},1); %..e grafica 0 ou 1, ultimo par�metro
CoefCophenetic(kkk,1) = c;
MaxNumClasses(kkk,:) = fVetorClasse2VetorTamanhoClasse(cSaida);  %..tamanho de cada grupo
[K,EQMT(kkk,1),nomes,PA(kkk,:),TamGrup(kkk,:),M] = fCompararClusterSaidaEntrada(classes,cSaida,numClasses); %..matriz de confus�o: Erro quadratico m�dio, nomes certos, Acc por classe, tamanho classes,amostras da matriz de confus�o,
cSaida = fTrocarNomesVetorClasses(cSaida,nomes); %..trocar os nomes de um vetor de classes segundo os nomes da tabela nomes
mPA = mean(PA,2); %..accur�cia m�dia
[maxPA,ImaxPA] = max(mPA); %..�ndice da classe com a m�x acur�cia

[accuracy,medidasD] = fMedidasMatrizConfusaoMulticlasse(K); %..acu�ria e taxas de desempenho

