clear all; close all; clc; format short;

load BDPBD %MOs NOs 
tamanhoClasses = [61 60 59]; 


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

%.........................declaração de variáveis..........................
NOS = [];                   %..para guardar o total de nós das matrizes padronizadas
NO = cell(1,totalEstancia); %..para os nós da rede original
MO = cell(1,totalEstancia); %..para guardar as matriz de adjacencia original
MM = cell(1,totalEstancia); %..para guardas as matrizes de adjacencia - não lembro porque 14
NN = cell(1,totalEstancia); %..para guardas os nós da matriz de adjacencia
CC = cell(1,totalEstancia); %..para guardas os nós da matriz de adjacencia
%..........................................................................

%for ibinario=1:8

%.........................Tipo de classificador............................
 NumClassificador = 8;
         Binarios = sistemadenumeracion(2,3);
TipoClassificador = Binarios(NumClassificador,:);
            ComCR = TipoClassificador(1);
       ComMedidaH = TipoClassificador(2);
   ComMedidaRedes = TipoClassificador(3);
        %ComPCAoFS = 1;
        if ComMedidaRedes==0
            usarPCA = 1;
        elseif ComMedidaRedes==1
            usarPCA = 0;
        end
        mostrarPCA=0;
%..........................................................................
%..................Validation Model Method.................................
%Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation'
ValidationModel = 4; 
TCT = 0.70; %..Tamanho do conjunto de teste, em porcentagem e entre 0-1;
%..........................................................................
%..cross-val: resposta ruim
%...h-d 50: más o menos, 
%..resubstitution: ruim estável em 60.5

%...Criar matriz de adjacência para cada estância e salvar todas em uma célula (cell)
if ComCR==0
    MO = MOs;
    NO = NOs;
elseif ComCR==1
    MO = MOc;
    NO = NOc;
end
%...............................................................................
%..tivar função Sequential feature selection
SFS = 0;
FS = cell(1,7);     %..para os salvar todas as caracteristicas selecionadas com fs variando
%...............................................................................




%limiarH = 0.2;      %..limiar de H fixo
ValoresLimiarH = [];
       TaxasMC = [];
            MC = [];
            TT = 0;
kkk = 1;            %..indice para salvar os valores de H
k = 1;
  %jj = 0.00;
alfa1 = 0.00;  %..minimax de C8 0.2602 j=0.001
alfa = 0.30; %..para C1
 Inc = 0.01;
 TotalRepeticoes = 10;
 
 
totalMatrizesAtrb = (alfa/Inc)+1;
medidasTodas = cell(1,totalMatrizesAtrb); %..(alfa/inc)+1
kk = 1;

 
 ValoresTotais = cell(1,TotalRepeticoes);
 tic
 for kkkk=1:TotalRepeticoes
     
     for jj=alfa1:Inc:alfa  %..valors para limiar de H
         %tic
         kkk;
         TT = 0;
         for i=1:totalEstancia
             Med = MO{i}; %..matriz de adj. original da instancia i
             nos = NO{i}; %..nós da rede original da instancia i
             
             if ComMedidaH==0
                 MmH = Med;
                 NosmH = nos;
                 com = 0;
             elseif ComMedidaH==1
                 limiarH = jj;
                 [MmH,NosmH,vH2,com] = ComunidadesLimHeApagar(Med,nos,limiarH); %..comunidades limiarH apagar nós
                 MaxAlfa(k) = max(vH2);                      %..máximos de relevância
             end
             
             %...padronizar todas as matrizes com o mesmo tamanho............
             nosj = unique(NosmH);
             if k==1
                 NOS = nosj; %..nos total
             else
                 novosNos = setdiff(nosj,NOS); %..devolve os valores de A que não estão em B
                 NOS = fConcatVetorColuna(NOS,novosNos);
                 %NOS = [NOS; novosNos'];    %..nós unicos para todas as redes
             end
             %..............................................................
             
             MM{1,k} = MmH;    %..matriz de adj. da rede reduzida
             NN{1,k} = NosmH;  %..nós da matriz de adj. da rede reduzida
             CC{1,k} = com;    %..vetor de comunidades após remoção
             TT = TT + length(NosmH);
             k = k + 1;
         end
         
         %...OJO: Ordenar MmH
         TotalNOS = length(NOS);
         
         
         %..criar matriz de medidas
         NumMedidas = 2;
         if ComMedidaRedes==1; medidas = zeros(totalEstancia,NumMedidas); else  medidas = zeros(totalEstancia,TotalNOS^2); end;
         
         %...Padronizar as matrizes para terem igual número de nós..........
         for i=1:totalEstancia
             Med = fcodeRitmo2MAdj(MM{1,i},NOS,NN{1,i},2); %..criar a matriz adj. com todos os nós
             %Med = MM{1,i}; %..não mudar o número de nós da Madj dá erro,
             
             if ComMedidaRedes==0
                 Med = reshape(Med,1,TotalNOS*TotalNOS);  %..mudar para vetor as caracteristicas são a MAdj.
                 medidas(i,:) = Med;
             elseif ComMedidaRedes==1
                 vaEm = [kkkk kkk jj i]
                      
                 medidas(i,:) = fMedidasRedesClassificacaoFinalENIAC(MM{1,i},TotalNOS); %..vetor medidas
                       
             end
         end
         
         medidasTodas{1,kk} = medidas;
         kk = kk + 1;
         
         %...........................Normalizar.............................
         medidasN = medidas;
         if ComMedidaRedes==0
              for j=1:size(medidas,1) %..por linhas
                  Mj = medidas(j,:);
                  medidasN(j,:) = (Mj-mean(Mj))./std(Mj);
                  %medidasN(j,:) = Mj/max(Mj);
              end
%          medidasN = bsxfun(@minus, medidas', mean(medidas'));
         elseif ComMedidaRedes ==1
             for j=1:size(medidas,2) %..por colunas sem medidas fica com muitos NaN e na classificação dá The variances in each group of TRAINING must be positive
                 Mj = medidas(:,j);
                 medidasN(:,j) = (Mj-mean(Mj))./std(Mj);
                 %medidasN(:,j) = Mj/max(Mj);
             end
         end
         %..................................................................
         
         
         %...........................Aplicar PCA............................
         if usarPCA==1
             LimiarPCA = 75; %..em porcentagem
             %B = zscore(medidasN);
             %[Y,lambda,A,Xs] = pca1(medidasN,size(B,2));
             [pc,score,ProVar,VarCum] = fPCA_COV_SVD(medidasN,LimiarPCA,3);
             medidasR = score;
             if mostrarPCA==1
                   nomes = {'Pasillo','Bambuco','Danza'}';
                   NomeClasses = fTamanhoClasses2VetorNomeClasses(tamanhoClasses,nomes);
                   figure(1); gscatter(score(:,1), score(:,2),NomeClasses,'ybr','.sd', [], 'on', 'Primeiro componente', 'Segundo componente'); grid on; %'First Component', 'Second Component'
                   figure(2); gscatter(score(:,1), score(:,3),NomeClasses,'ybr','.sd', [], 'on', 'Primeiro componente', 'Terceiro componente'); grid on;  %'First Component', 'Third Component'
                   %figure(3); gscatter(score(:,2), score(:,3),NomeClasses, [], [], [], 'on', 'Segundo componente', 'Terceiro componente'); grid on;  %'First Component', 'Third Component'
                   figure(4); plot(VarCum,'--ko','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7);
                   axis([1 15 1 100]);
                   ylabel('Variância acumulada (%)');  %Cumulative Variance Captured (%)
                   xlabel('Número de componentes principais');       %Principal Componente Number
                   hold on;
                   h = bar(ProVar,'FaceColor', 'k');
                   bar(ProVar(1), 'FaceColor', 'red');
                   legend('Proporção de variância explicada','Location','NorthWest'); %.Proportion of Variance Explained
             end
             
         else
             medidasR = medidasN;
         end
         %..................................................................
         
         
         %.................Aplicar seleção de caracteristicas.......................
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
         %..cross-validation k=10 CVPARTITION(classes,'Kfold',10) CVPARTITION(N,'Holdout',0.3) CVPARTITION(N,'Resubstitution')
         
              if ComMedidaH==1 && SFS==1
                     opts = statset('display','iter');
             [fs,history] = sequentialfs(@erroClassificador,medidasN,classes,'cv',CVO,'options',opts); %..função Sequential feature selection
               colunasAtr = find(fs);
                FS{1,kkk} = colunasAtr;
                medidasR = medidasN(:,[1 2]); %colunasAtr);
              end
         %..........................................................................
         
         %.....Aplicar o classificador com os atributos calculados..................
         %medidasR = medidasN;
         nt = CVO.NumTestSets; %..número de teste = 10
         err = zeros(nt,1);    %..vetor para guardas os erros de cada etapa de classificação.
         for i = 1:nt
             tTreino = CVO.training(i);       %..vetor indicando a classe do conjunto de treino
             tTeste = CVO.test(i);           %..vetor indicando a classe do conjunto de teste
             cTeste = medidasR(tTeste,:);    %..conjunto de teste
             cTreino = medidasR(tTreino,:);   %..conjunto de treino
             cClasses = classes(tTreino,:);    %..conjunto de classes
             
             %Bayes_Model = NaiveBayes.fit(cTreino, cClasses, 'Distribution','kernel');
             %   [cSaida] = Bayes_Model.predict(cTeste);
             
             cSaida = classify(cTeste,cTreino,cClasses,'diagquadratic');%'linear'); %'diagquadratic'); %'diaglinear'); %  %..classificar
             err(i) = sum(cSaida~=classes(tTeste));
             [cm,order] = confusionmat(classes(tTeste),cSaida); cm = cm';%ojo CMij, linhas entradas (grupo conhecido), j saídas (classe predita)
             [accuracy(i),taxas] = fMedidasMatrizConfusaoMulticlasse(cm);
             taxasS(:,:,i) = taxas(:,[1 2 3 4 5]); %..S E P NPV F1
             [IndiceKappa(i),varKappa(i)] = fIndiceKappa(cm);
         end
         IndiceKappaM = mean(IndiceKappa);
         VarianceKappaM = mean(varKappa);
         for i=1:NumClasses; for j=1:5; as(i,j) = mean(taxasS(i,j,:)); end; end;
         cvErr = mean((err'./CVO.TestSize)*100); %..1-mean(accuracy)
         AcuraciaMedia = mean(accuracy);
         %.........................................................................
         format bank
         ValoresLimiarH(kkk,:)= [jj TotalNOS IndiceKappaM VarianceKappaM AcuraciaMedia TT];
         TaxasMC(:,:,kkk) = as; %..taxas 3x5 para cada valor de alfa
         MC(:,:,kkk) = cm; %..matriz de confusão 3x3 para cada valor de alfa
         kkk = kkk + 1;
         k = 1; %..para rodar para varios valores de H
     end
     kkk = 1;
     Valores{1,kkkk} = ValoresLimiarH;
     kkkk = kkkk + 1;
 end

 if  ((NumClassificador==7)||(NumClassificador==8)) & alfa>0
     
     %AMi = zeros(totalMatrizesAtrb,TotalRepeticoes);
     AMi = [];
     for i=1:TotalRepeticoes
         AMi = [AMi Valores{1,i}(:,5)];
     end
     AM = mean(AMi,2);
     if TotalRepeticoes>1
      erro = std(AMi')'; %/sqrt(NumMedidas);
     else
      erro = zeros(length(AM),1);
     end
     
     totalnos = ValoresLimiarH(:,6);
     totalnosU = ValoresLimiarH(:,2);
     t=ValoresLimiarH(:,1);
     
     figure(1);
     subplot(3,1,1);
     plot(t,totalnos,':o');
     %ylabel('Total RCs');
     %xlabel('Relevância limiar');
     legend({'Total RCs'});
     axis([0 alfa min(totalnos)-10 max(totalnos)+10]);
     subplot(3,1,2);
     plot(t,totalnosU,':o');
     %ylabel('Número total de nós únicos');
     %xlabel('Relevância limiar');
     legend({'Total nodes'});
     axis([0 alfa min(totalnosU)-10 max(totalnosU)+10]);
     %plot(t,AM*100,'ro','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',8);
     subplot(3,1,3);
     errorbar(t,AM*100,erro*100,'-.r');
     axis([0 alfa min(AM*100)-min(erro*100)-2 max(AM*100)+max(erro*100)+2]);
     %ylabel('Acurácia média de classificação');
     xlabel('Threshold relevance');
     legend({'Average accuracy (%)'});
     
     
     %..calcular e graficar a tendência
%      figure(2)
%      errorbar(t,AM*100,erro');
%      axis([0 alfa 0 100]);
     
     % cubicCefficients = polyfit(t, AM*100, 10)
     % xFit = linspace(0, alfa, 10);
     % yFit = polyval(cubicCefficients, xFit);
     % hold on;
     % plot(xFit, yFit, 'b--', 'LineWidth', 1);
     % grid on;
     
     %..salvar valores importantes
     [a,b]=max(ValoresLimiarH(:,4));
     MaxAlfaAcuraia = [ValoresLimiarH(b,1) ValoresLimiarH(b,2) ValoresLimiarH(b,3) ValoresLimiarH(b,4) 0  ValoresLimiarH(1,2) ValoresLimiarH(1,3)  ValoresLimiarH(1,4) VarianceKappaM]
     
     
     
 end
ValoresF = [jj TotalNOS IndiceKappaM VarianceKappaM AcuraciaMedia]

%..para calcular a maior diferença entre todas as 10 repetições
maxDif = zeros(1,TotalRepeticoes);
for j=1:TotalRepeticoes
    maxDif(1,j) = max(Valores{1,j}(:,5))-Valores{1,j}(1,5);
end


%..mostras as taxas e a matriz de confusão do máximo acc
[a,b]=fMaxRepetidos(ValoresLimiarH(:,4)');
Imax = b{1}(end);
TaxasMC(:,:,Imax) %..medidas de desempenho
     MC(:,:,Imax) %..matriz de confusão

%..salvar resultados 
%save ValoresClassifiBDPBDC8HD70Dalfa01Teste2 TaxasMC MC ValoresLimiarH MaxAlfa Imax
%..........................................................................
toc
TCT;

fim = 1;
%..........................................................................




% %...PCA
% [pc,score,latent] = princomp(medidas);
% medidasPCA = cumsum(latent)./sum(latent);
% i = 1;
% NumCompo = 0;
% flag = 0;
% while flag==0;
%     if medidasPCA(i)>0.75
%         flag = 1;
%         NumCompo = i;
%     else
%        i = i+1;
%        flag = 0;
%     end
% end
% biplot(pc(:,1:2),'Scores',score(:,1:2))
%
% %..criar um arquivo com as medidas
% % xlswrite('medidasMAdjBD.xlsx',medidas)
%
% %..graficar as medidas
% x = medidas(:,1:2);
% gscatter(x(:,1),x(:,2),classes)
% set(legend,'location','best')
%
% %....................Classificadores.......................................
% %....LDA
% % Calculate linear discriminant coefficients
% W = LDA(medidas,classes);
% % Calulcate linear scores for training data
% L = [ones(53,1) medidas] * W';
% % Calculate class probabilities
% P = exp(L) ./ repmat(sum(exp(L),2),[1 3])
%
% %...Arvore de regressão
% tMC = classregtree(medidas,classes)
%
% %..Knn
% % mdl = ClassificationKNN.fit(medidas,classes,'NumNeighbors',4);
%  cmdl = ClassificationKNN.fit(medidasN1,classes,'NSMethod','exhaustive','Distance','cosine');
%  cmdl.NumNeighbors = 3;
%  closs = resubLoss(cmdl)
% cvmdl = crossval(cmdl)
% kloss = kfoldLoss(cvmdl)
% flwr = mean(medidas); % an average flower
% flwrClass = predict(cmdl,flwr)
% %..........................................................................

%..Avaliar os classificadores..............................................
% cSaida = classify(cTeste,cTreino,cClasses,'diagquadratic');   %..classificar
%         classesS = classify(medidasR,medidasR,classes,'diagquadratic'); %..classificar sem partição
%         erro = sum(classes~=classesS); %..classes classificadas - classe original
%         Mclasses1 = MatrizClasses(classes,tamanhoClasses)';
%         Mclasses2 = MatrizClasses(classesS,tamanhoClasses)';
%         [c,cm,ind,per] = confusion(Mclasses1,Mclasses2);
% [tpr,fpr,thresholds] = roc(Mclasses1,Mclasses2)
% figure(1)
% plotconfusion(Mclasses1,Mclasses2)
% figure(2)
% plotroc(Mclasses1,Mclasses2)


