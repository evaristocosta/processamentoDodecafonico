function adaErrokFold = kfoldAda(medidasR,classes)
%[medidasR, classes] = medidas();
%classesOrg = classes;
%classes(1:19) = -1;

CVO = cvpartition(classes,'Kfold',10);

nt = CVO.NumTestSets; %..n�mero de teste = 10
adaboostError = zeros(nt,1);    %..vetor para guardas os erros de cada etapa de classifica��o.

for i = 1:nt
    tTreino = CVO.training(i);       %..vetor indicando a classe do conjunto de treino
    tTeste = CVO.test(i);           %..vetor indicando a classe do conjunto de teste
    cTeste = medidasR(tTeste,:);    %..conjunto de teste
    cTreino = medidasR(tTreino,:);   %..conjunto de treino
    cClasses = classes(tTreino,:); 
    
    [classestimate,model]=adaboost('train',cTreino,cClasses,30); 
    
    cSaida = adaboost('apply',cTeste,model);
    err(i) = sum(cSaida~=classes(tTeste))/length(cSaida);
    
    for k=1:length(classestimate)
       if(classestimate(k) ~= 1)
           classestimate(k) = 0;
       end
    end
end
adaErrokFold = mean(err);
end