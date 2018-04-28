function [c,K,cSaida,mPA] = HierarquicoNS()

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'numeric');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.
%Using JDBC driver.
conn = database('dodecaf', 'evaristo', '746136', 'Vendor', 'POSTGRESQL', 'Server', 'localhost', 'PortNumber', 5432);

%Read data from database.
curs = exec(conn, ['SELECT 	measures.id'...
    ' ,	measures.ec'...
    ' ,	measures.ecp'...
    ' ,	measures.ecn'...
    ' ,	measures.mpp'...
    ' ,	measures.dcd'...
    ' ,	measures.dca'...
    ' FROM 	 ( "dodecaf"."public".everything '...
    ' RIGHT JOIN "dodecaf"."public".measures '...
    ' ON 	everything.num = measures.num )'...
    ' WHERE 	everything.compositor = ''Arnold Schoenberg'''...
    ' OR 	everything.compositor = ''Igor Stravinsky''']);
%    ' FROM 	"dodecaf"."public".measures ']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
medidasR = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn

NumAmostras=max(medidasR,1);

%............Medida de dist�ncia e m�todo de agrupamento...................
MDist = {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'};
MAgru = {'single','complete','average','weighted','centroid','median','ward'};

%..........................................................................

%...classificar n�o supervisionado - hierarquico
% 
% for x=1:10
%    for y=1:6
%         Y = pdist(medidasR,MDist{x});     %..Medidas de similaridade - vetor linha       
%        % MY = squareform(Y);           %..Matriz de medidas de similaridade, igual a Y, por�m em matriz 
%         Z = linkage(Y,MAgru{y}); %..Criar os enlaces segundo a similaridade. Matriz 3 colunas, col1-col2: amostras agrupados, col3; dist�ncia entre os objetos  
%         c(x,y) = cophenet(Z,Y);           %..Coeficiente de correla��o Cophenetic 
%     end        
% end

% Y = pdist(medidasR,MDist{10});     %..Medidas de similaridade - vetor linha       
% % MY = squareform(Y);           %..Matriz de medidas de similaridade, igual a Y, por�m em matriz 
% Z = linkage(Y,MAgru{3});
% I = inconsistent(Z);          %..Matriz de inconsist�ncia. 
% mI = max(I(:,4));
% Te = cluster(Z,'cutoff',mI-0.0000001);
% graficar(Te,Z,Y,NumAmostras);
% 
% 
% var = zeros(size(Te));
% for i = 1:length(Te)
%     var(i) = sum(Te==Te(i));
% end
% 
% saida=var;
% 

mPA=zeros(10,6);


tamanhoClasses = [19 19]; 

%..........................Vetor de classes................................
totalEstancia = sum(tamanhoClasses);
numClasses = size(tamanhoClasses,2);
classes = [];

for i=1:numClasses
    classesi = zeros(tamanhoClasses(i),1) + i-1;
    classes = [classes; classesi];
end

NumClasses = max(classes) + 1;
% %..........................................................................

[cSaida,Z,c,I,Te] = fClusteringHierarquico(medidasR,NumClasses,MDist{7},MAgru{3},1); %..e grafica 0 ou 1, ultimo par�metro
CoefCophenetic(1,1) = c;
MaxNumClasses(1,:) = fVetorClasse2VetorTamanhoClasse(cSaida);  %..tamanho de cada grupo
[K,EQMT(1,1),nomes,PA(1,:),TamGrup(1,:),M] = fCompararClusterSaidaEntrada(classes,cSaida,numClasses); %..matriz de confus�o: Erro quadratico m�dio, nomes certos, Acc por classe, tamanho classes,amostras da matriz de confus�o,
cSaida = fTrocarNomesVetorClasses(cSaida,nomes); %..trocar os nomes de um vetor de classes segundo os nomes da tabela nomes
mPA = mean(PA,2); %..accur�cia m�dia
[maxPA,ImaxPA] = max(mPA); %..�ndice da classe com a m�x acur�cia

[accuracy,medidasD] = fMedidasMatrizConfusaoMulticlasse(K); %..acu�ria e taxas de desempenho

% 
% for x=1:10
%     for y=1:6
%         [cSaida,Z,cophe,I,Te] = fClusteringHierarquico(medidasR,NumClasses,MDist{x},MAgru{y},0); %..e grafica 0 ou 1, ultimo par�metro
%         [K,EQMT(1,1),nomes,PA(1,:),TamGrup(1,:),M] = fCompararClusterSaidaEntrada(classes,cSaida,numClasses); %..matriz de confus�o: Erro quadratico m�dio, nomes certos, Acc por classe, tamanho classes,amostras da matriz de confus�o,
%         mPA(x,y) = mean(PA,2); %..accur�cia m�dia
%     end 
% end 