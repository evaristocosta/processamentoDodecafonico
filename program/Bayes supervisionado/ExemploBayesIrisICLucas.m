
%..iris data: https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
load fisheriris.mat

medidasR = meas;

tamanhoClasses = [50 50 50]; 
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

%..................Validation Model Method.................................
%Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation'
ValidationModel = 1 ; 
TCT = 0.70; %..Tamanho do conjunto de teste, em porcentagem e entre 0-1;
%..........................................................................

TotalRepeticoes = 10;

%.................Aplicar sele��o de caracteristicas.......................
switch ValidationModel
    case 1
        CVO = cvpartition(classes,'Resubstitution');
    case 2
        CVO = cvpartition(classes,'Holdout',TCT); %..TCT: Tamanho do conjunto de teste entre 0-1
    case 3
        CVO = cvpartition(classes,'Holdout',0.5);
    case 4
        CVO = cvpartition(classes,'Kfold',10);
    otherwise
        disp('Error: Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation')
end

%.....Aplicar o classificador com os atributos calculados..................
nt = CVO.NumTestSets; %..n�mero de teste = 10
err = zeros(nt,1);    %..vetor para guardas os erros de cada etapa de classifica��o.
for i = 1:nt
    tTreino = CVO.training(i);       %..vetor indicando a classe do conjunto de treino
    tTeste = CVO.test(i);           %..vetor indicando a classe do conjunto de teste
    cTeste = medidasR(tTeste,:);    %..conjunto de teste
    cTreino = medidasR(tTreino,:);   %..conjunto de treino
    cClasses = classes(tTreino,:);    %..conjunto de classes
    
    cSaida = classify(cTeste,cTreino,cClasses,'diagquadratic'); %'linear'); %'diagquadratic'); %'diaglinear'); %  %..classificar
    err(i) = sum(cSaida~=classes(tTeste));
    [cm,order] = confusionmat(classes(tTeste),cSaida); cm = cm'; %CMij, linhas entradas (grupo conhecido), j sa�das (classe predita)
    [accuracy(i),taxas] = fMedidasMatrizConfusaoMulticlasse(cm);
    taxasS(:,:,i) = taxas(:,[1 2 3 4 5]); %..S E P NPV F1
    [IndiceKappa(i),varKappa(i)] = fIndiceKappa(cm);
end

fim = 1;