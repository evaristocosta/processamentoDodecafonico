# Algoritmos para tarefas de identificação e caracterização de compositores dodecafônicos

Neste repositório, estão vários algoritmos usados na tarefa de identificação automática e caracterização de compositores da música dodecafônica, a partir das séries de notas escolhidas para composição das obras, bem como mediante análise das séries empregadas nas músicas.

Os algoritmos estão codificados em MATLAB. Trabalhos que usam esses algoritmos são:
- [Characterization and identification of twelve-tone composers (ENIAC 2018);](https://www.researchgate.net/publication/330351016_Characterization_and_identification_of_twelve-tone_composers)
- Dodecaphonic Composer Identification Based On Complex Networks (BRACIS 2019, ainda não publicado).

Para reprodutibilidade dos resultados obtidos no segundo artigo, tendo feito o download do repositório, é necessário executar a seguinte sequência de funções:
- ```inicializadorBRACIS2019()```: funciona como banco de dados, contendo todas as informações de séries e ordem de séries empregadas por obra. Retorna matriz com todas medidas descritas no artigo calculadas e organizadas por classes (primeira linha), sendo 0 para Stravinsky, 1 para Webern e 2 para Schoenberg;
- ```bagged(trainingData); boosted(trainingData); subspaced(trainingData)```: realiza a classificação dos dados e retorna a acurácia e outros dados relevantes para construção de gráficos e da matriz de confusão. ```trainingData``` é a matriz ```totalcomtop```, resultante da função anterior;
- Para obter dados individuais das redes, é preciso obter a matriz de adjacência das obras de um compositor, executando, por exemplo:
```
full(grafoDeOrdem(ordemstravinsky, '',0));
```
e a aplicando como argumento na função ```mseletas(W)```;

- Os plots de ROC sobrepostos podem ser executados com a seguinte sequência de comandos:
```
figure('Renderer', 'painters', 'Position', [10 10 420 300])
diffscores = validationScores(:,1) - max([validationScores(:,2),validationScores(:,3)]);
[X,Y,T,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),0);
plot(X,Y,'Color',[0 0.4470 0.7410],'LineStyle', '-', 'LineWidth',4.4)
xlim([-.05 1.05])
ylim([-.05 1.05])

hold on

diffscores = validationScores(:,2) - max([validationScores(:,1),validationScores(:,3)]);
[X,Y,T,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),1);
plot(X,Y,'Color',[0.8500 0.3250 0.0980],'LineStyle', '--', 'LineWidth',4.4)
xlim([-.05 1.05])
ylim([-.05 1.05])

diffscores = validationScores(:,3) - max([validationScores(:,2),validationScores(:,1)]);
[X,Y,T,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),2);
plot(X,Y,'Color',[0.9290 0.6940 0.1250],'LineStyle', ':', 'LineWidth',4.4)
xlim([-.05 1.05])
ylim([-.05 1.05])

line([0 1],[0 1],'Color','k','LineStyle', '--', 'LineWidth',1.5)

hold off
```
e a matriz de confusão, usando ```confusionmat(response,validationPredictions)```. Importante notar que os argumentos usados nestas funções são resultado de um dos métodos de aprendizado de máquina.

Bibliotecas externas estão incluidas neste repositório, como [Octave Networks Toolbox](https://www.researchgate.net/publication/308789774_Octave_Networks_Toolbox) e [Classic AdaBoost Classifier](https://www.mathworks.com/matlabcentral/fileexchange/27813-classic-adaboost-classifier). Demais bibliotecas serão citadas posteriormente.
