function [varKappa,accuracyAll,IndiceKappa] = aprendizado(saida)

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
    ' ,	measures.dca'...
    ' ,	measures.dcd'...
    ' FROM 	 ( "dodecaf"."public".everything '...
    ' RIGHT JOIN "dodecaf"."public".measures '...
    ' ON 	everything.num = measures.num )'...
    ' WHERE 	everything.compositor = ''Arnold Schoenberg'''...
    ' OR 	everything.compositor = ''Igor Stravinsky''']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
medidasR = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn

tamanhoClasses = [19 19]; 
%..........................Vetor de classes................................
% totalEstancia = sum(tamanhoClasses);
% numClasses = size(tamanhoClasses,2);
% classes = [];
% 
% for i=1:numClasses
%     classesi = zeros(tamanhoClasses(i),1) + i-1;
%     classes = [classes; classesi];
% end

%..........................................................................
%..................Validation Model Method.................................
%Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation'

ValidationModel = 2 ; 
TCT = 0.60; %..Tamanho do conjunto de teste, em porcentagem e entre 0-1;

%..........................................................................

%TotalRepeticoes = 10;

%.................Aplicar sele��o de caracteristicas.......................
switch ValidationModel
    case 1
        CVO = cvpartition(saida,'resubstitution');
    case 2
        CVO = cvpartition(saida,'Holdout',TCT); %..TCT: Tamanho do conjunto de teste entre 0-1
    case 3
        CVO = cvpartition(saida,'Holdout',0.7);
    case 4
        CVO = cvpartition(saida,'Kfold',5);
    otherwise
        disp('Error: Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation')
end


%.....Aplicar o classificador com os atributos calculados..................
% cSaidaAll=zeros(4,10);
% cTesteAll=zeros(4,7);
nt = CVO.NumTestSets; %..n�mero de teste = 10
err = zeros(nt,1);    %..vetor para guardas os erros de cada etapa de classifica��o.

for i = 1:nt
    tTreino = CVO.training(i);       %..vetor indicando a classe do conjunto de treino
    tTeste = CVO.test(i);           %..vetor indicando a classe do conjunto de teste
    cTeste = medidasR(tTeste,:);    %..conjunto de teste
    cTreino = medidasR(tTreino,:);   %..conjunto de treino
    cClasses = saida(tTreino,:);    %..conjunto de classes
        
    cSaida = classify(cTeste,cTreino,cClasses,'diagquadratic'); %'linear'); %'diagquadratic'); %'diaglinear'); %  %..classificar
        
    err(i) = sum(cSaida~=saida(tTeste));
    [cm,order] = confusionmat(saida(tTeste),cSaida); cm = cm'; %CMij, linhas entradas (grupo conhecido), j sa�das (classe predita)
    [accuracy(i),taxas] = fMedidasMatrizConfusaoMulticlasse(cm);
    %taxasS(:,:,i) = taxas(:,[1 2 3 4 5]); %..S E P NPV F1
    [IndiceKappa(i),varKappa(i)] = fIndiceKappa(cm);
    
end
accuracyAll=mean(accuracy);
end