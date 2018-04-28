function kmeansErro = kfoldKMeans()
[medidasR, classes] = medidas();

CVO = cvpartition(classes,'Kfold',10);

nt = CVO.NumTestSets; %..n�mero de teste = 10
err = zeros(nt,1);    %..vetor para guardas os erros de cada etapa de classifica��o.

for i = 1:nt
    tTreino = CVO.training(i);       %..vetor indicando a classe do conjunto de treino
    cTreino = medidasR(tTreino,:);   %..conjunto de treino
    
    cSaida = kmeans(cTreino, 2);
    err(i) = sum(cSaida~=classes(tTreino))/length(cSaida);
end
kmeansErro = mean(err);
end