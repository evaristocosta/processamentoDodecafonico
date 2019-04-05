close all; clc; format short;

load BDPBD %MOs NOs MOc NOc
tamanhoClasses = [61 60 59]; 
%...ojo com amostra 102, 14 nós, a unica comunidade com maior relevancia tem 1 nó 

% load MatrizAdjNosClasseBancoDadosDeboraDaiN=4 %MatrizAdj Nos Classe
% MOc = MatrizAdj;
% NOc = Nos;
% tamanhoClasses = fVetorClasse2VetorTamanhoClasse(Classe); 



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

%............Medida de distância e método de agrupamento...................
% MDist = {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'}; %..tirei  'mahalanobis',
% MAgru = {'single','complete','average','weighted','centroid','median','ward'};
MDist = {'cosine'};  %..tirei 'mahalanobis',
MAgru = {'average'}; %MAgru = {'complete','average','ward'};

L1 = length(MDist);
L2 = length(MAgru);
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
%..........................................................................
%..................Validation Model Method.................................
%Model validation technique: (1) Resubstitution, (2) Holdout 70%, (3) Holdout 50%, (4) cross-validation'
ValidationModel = 1;
%..........................................................................


%...Criar matriz de adjacência para cada estância e salvar todas em uma célula (cell)
if ComCR==0
    MO = MOs;
    NO = NOs;
elseif ComCR==1
    MO = MOc;
    NO = NOc;
end
%...............................................................................


%FS = cell(1,7);     %..para os salvar todas as caracteristicas selecionadas com fs variando
K = [];
%limiarH = 0.2;      %..limiar de H fixo
TN = []; %..para guardar total nos
AM = []; %..para guardar as acurácias
ValoresLimiarH = [];
kkk = 1;            %..indice para salvar os valores de H
k = 1;
alfa = 0.17;  Inc = 0.17; alfa1 = 0.17;
CoefCophenetic = zeros(L1*L2,1);
 MaxNumClasses = zeros(L1*L2,numClasses);
          EQMT = zeros(L1*L2,1);
            PA = zeros(L1*L2,numClasses);
          
           
           
for Md=1:L1
    for Ma=1:L2
        for jj=alfa1:Inc:alfa  %..valors para limiar de H
            tic
            
            for i=1:totalEstancia
                Med = MO{i}; %..matriz de adj. original da instancia i
                nos = NO{i}; %..nós da rede original da instancia i
                
                if ComMedidaH==0
                    MmH = Med;
                    NosmH = nos;
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
                   
                end
                %..............................................................
                    
            MM{1,k} = MmH;    %..matriz de adj. da rede reduzida
            NN{1,k} = NosmH;  %..nós da matriz de adj. da rede reduzida
            CC{1,k} = com;    %..vetor de comunidades após remoção
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
                
                if ComMedidaRedes==0
                    Med = reshape(Med,1,TotalNOS*TotalNOS);  %..mudar para vetor as caracteristicas são a MAdj.
                    medidas(i,:) = Med;
                elseif ComMedidaRedes==1
                    %............Medidas  para MTn..........................................
                    vaEm = [kkk jj i]
      
                    medidas(i,:) = fMedidasRedesClassificacaoFinalENIAC(MM{1,i},TotalNOS); %..vetor medidas
                    
                end
                end
                
                %...........................Normalizar.............................
                    medidasN = medidas;
                if ComMedidaRedes==0
                    for j=1:size(medidas,1) %..por linhas
                        Mj = medidas(j,:);
                        medidasN(j,:) = (Mj-mean(Mj))./std(Mj);
                        %medidasN(j,:) = Mj/max(Mj);
                    end
                elseif ComMedidaRedes ==1
                    for j=1:size(medidas,2) %..por colunas sem medidas fica com muitos NaN e na classificação dá The variances in each group of TRAINING must be positive
                        Mj = medidas(:,j);
                        medidasN(:,j) = (Mj-mean(Mj))./std(Mj);
                        %medidasN(j,:) = Mj/max(Mj);
                    end
                end
                %..................................................................
                    
            
            %...........................Aplicar PCA............................
                if usarPCA==1
                LimiarPCA = 1;
                B = zscore(medidasN);
                [medidasR,VarCum,score,proportion_of_variance] = fAplicarPCA(B,LimiarPCA);
                nomes = {'Pasillo','Bambuco','Danza'}';
                NomeClasses = fTamanhoClasses2VetorNomeClasses(tamanhoClasses,nomes);
                figure(1); gscatter(score(:,1), score(:,2),NomeClasses, [], [], [], 'on', 'First Component', 'Second Component'); grid on;
                figure(2); gscatter(score(:,1), score(:,3),NomeClasses, [], [], [], 'on', 'First Component', 'Third Component'); grid on;
                figure(3); plot(VarCum*100,'--ko','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7); axis([1 20 1 120]); ylabel('Cumulative Variance Captured (%)'); xlabel('Principal Componente Number');
                hold on;
                h = bar(proportion_of_variance,'FaceColor', 'k');
                bar(proportion_of_variance(1), 'FaceColor', 'red');
                legend('Proportion of Variance Explained');
                
                else
                    medidasR = medidasN;
                end
                %..................................................................
                    
            %.....Aplicar o classificador com os atributos calculados..................
        kkk
        [cSaida,Z,c,I] = fClusteringHierarquico(medidasR,NumClasses,MDist{Md},MAgru{Ma},1); %..e grafica 0 ou 1, ultimo parâmetro
        CoefCophenetic(kkk,1) = c;
        MaxNumClasses(kkk,:) = fVetorClasse2VetorTamanhoClasse(cSaida);  %..tamanho de cada grupo
        [K,EQMT(kkk,1),nomes,PA(kkk,:),TamGrup(kkk,:),M] = fCompararClusterSaidaEntrada(classes,cSaida,numClasses); %..matriz de confusão: Erro quadratico médio, nomes certos, Acc por classe, tamanho classes,amostras da matriz de confusão, 
        cSaida = fTrocarNomesVetorClasses(cSaida,nomes); %..trocar os nomes de um vetor de classes segundo os nomes da tabela nomes
        mPA = mean(PA,2); %..accurácia média
        [maxPA,ImaxPA] = max(mPA); %..índice da classe com a máx acurácia
        
        [accuracy,medidasD] = fMedidasMatrizConfusaoMulticlasse(K); %..acuária e taxas de desempenho
        [AR,RI,MI,HI]=RandIndex(classes+1,cSaida);  %..índice de rand
        
%         err(i) = sum(cSaida~=classes);
%         [cm,order] = confusionmat(classes,cSaida);
%         [accuracy,medidas] = fMedidasMatrizConfusaoMulticlasse(cm);
%         medidasS(:,:,i) = medidas(:,1:6);
%         [IndiceKappa,varKappa] = fIndiceKappa(cm);
%         
%         IndiceKappaM = mean(IndiceKappa)
%         VarianceKappaM = mean(varKappa)
%         for i=1:NumClasses; for j=1:6; as(i,j) = mean(medidasS(i,j,:)); end; end;
%         AcuraciaMedia = accuracy;
        %.........................................................................
         
        TN = [TN TotalNOS];
        AM = [AM accuracy];
        %ValoresLimiarH(kkk,:)= [jj TotalNOS IndiceKappaM AcuraciaMedia VarianceKappaM];
        kkk = kkk + 1;
        k = 1; %..para rodar para varios valores de H
        end
    end
end

% if  ((NumClassificador==7)||(NumClassificador==8)) & alfa>0
% figure(1);
% t=0:Inc:alfa;
% plot(t,TN,'o','MarkerSize',8);
% hold on; 
% plot(t,AM*100,'ro','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',8);
% axis([0 alfa 0 150]);
% legend({'Total nós','Acurácia média (%)','Tendência'});
% xlabel('Relevance limit')
% 
% %..calcular e graficar a tendência
% cubicCefficients = polyfit(t, AM*100, 3)
% xFit = linspace(0, alfa, 10);
% yFit = polyval(cubicCefficients, xFit);
% hold on;
% plot(xFit, yFit, 'b-', 'LineWidth', 2);
% grid on;
% 
% 
% end



K        %..Matriz de confusão
c        %..coeficiente cophenetic
PA       %..acurácia por classe
mPA      %..acurácia média
M{1,1}';  %..amostras do grupo 1
M{2,2}';  %..amostras do grupo 2
M{3,3}';  %..amostras do grupo 3
accuracy %..acurácia
medidasD;  %..taxas de desempenho
RI       % ARI
max(AM)
fim = 1;
%..........................................................................



