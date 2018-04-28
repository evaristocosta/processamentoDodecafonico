%..fun��o que aplica clustering hierarquico a uma matriz de
%caracter�sticas X, entra o n�mero de classes conhecido ou desejada, o
%m�todo para calcular as dist�ncias, e o m�todo de agrupamento.
%..sa�da
% VetorClasseSaida: vetor coluna classes de sa�da
% Z: Matriz de similaridade. Matriz 3 colunas, col1-col2: amostras agrupados, col3; dist�ncia entre os objetos 
% c: Coeficiente de correla��o Cophenetic 
% I: Matriz de inconsist�ncia. 

function [VetorClasseSaida,Z,c,I] = fClusteringHierarquico(X,Nc,Mdistancia,Magrupamento,OpGraficar)
%X : Matriz de caracter�sticas dados de entrada 
%option: 1, agrupamento segundo o m�x. valor de inconsist�ncia, 0 agrupamento com um n�mero de classes de entrada
%Nc:     n�mero de classes, grupos 
%..exemplo: 
%..rand('state', 7); X = [rand(10,3); rand(10,3)+1; rand(10,3)+2]; 
%..[VetorClasseSaida,Z,c,I] = fClusteringHierarquico(X,0,3)

%option = 0;
%Nc = 3; %..n�mero de classes que j� � conhecido
%X = [1 2 4;2.5 4.5 3;2 2 1.1 ;4 1.5 2.5;4 2.5 1.6];

NumAmostras = size(X,1);

switch nargin
    case 1
        option = 1; %..para calcular Nc
        Mdistancia   = 'euclidean';
        Magrupamento = 'single';
    case 2
        option = 0;
        Mdistancia   = 'euclidean';
        Magrupamento = 'single' ;
     case 3
        option = 0;
        Magrupamento = 'single';
     case 4
        option = 0;
     case 5
        option = 0;
    otherwise
        disp('N�mero de argumentos de entrada deve ser maior a 0');
end

 Y = pdist(X,Mdistancia);     %..Medidas de similaridade - vetor linha
MY = squareform(Y);           %..Matriz de medidas de similaridade, igual a Y, por�m em matriz
 Z = linkage(Y,Magrupamento); %..Criar os enlaces segundo a similaridade. Matriz 3 colunas, col1-col2: amostras agrupados, col3; dist�ncia entre os objetos 
 c = cophenet(Z,Y);           %..Coeficiente de correla��o Cophenetic 
I = inconsistent(Z);          %..Matriz de inconsist�ncia. 

if option==1
                  mI = max(I(:,4)); %..Maior valor de inconsist�ncia
    VetorClasseSaida = cluster(Z,'cutoff',mI);
                  Nc = max(unique(VetorClasseSaida))
elseif option==0
    VetorClasseSaida = cluster(Z,'maxclust',Nc);
end

leafOrder = optimalleaforder(Z,Y); %..ordem �tima � um vetor com os n�m. das amostras
NumFolhas = 60;
if OpGraficar==1
    if Nc>1    
        color = Z(end-Nc+2,3)-eps;
        [H,T,perm] = dendrogram(Z,NumFolhas, 'colorthreshold', color,'Reorder',leafOrder,'Orientation','rigth');
        set(H,'LineWidth',2)
         set(gca,'XTick',0:NumAmostras,'FontSize',10);
%         xticklabel_rotate([1:NumAmostras],90,'interpreter','none')
    else
        [H,T,perm] = dendrogram(Z,'Reorder',leafOrder);
         set(gca,'XTick',0:NumAmostras,'FontSize',10);
         xticklabel_rotate([1:NumAmostras],90,'interpreter','none')
    end
end

%..medidas de dist�ncias para pdis
%1.      'euclidean'   - Euclidean distance (default)
%2.       'seuclidean'  - Standardized Euclidean distance. 
%3.       'cityblock'   - City Block distance
%4.       'minkowski'   - Minkowski distance. 
%5.       'chebychev'   - Chebychev distance (maximum coordinate difference)
%6.       'mahalanobis' - Mahalanobis distance, using the sample covariance of X as computed by NANCOV. 
%7.       'cosine'      - One minus the cosine of the included angle between observations (treated as vectors)
%8.       'correlation' - One minus the sample linear correlation between observations (treated as sequences of values).
%9.       'spearman'    - One minus the sample Spearman's rank correlation between observations (treated as sequences of values).
%10.      'hamming'     - Hamming distance, percentage of coordinates that differ
%11.      'jaccard'     - One minus the Jaccard coefficient, the percentage of nonzero coordinates that differ

%..M�todos de agrupamento usados pela fun��o Linkage
%1.      'single'    --- nearest distance (default)
%2.     'complete'  --- furthest distance
%3.      'average'   --- unweighted average distance (UPGMA) (also known as group average)
%4.      'weighted'  --- weighted average distance (WPGMA)
%5.      'centroid'  --- unweighted center of mass distance (UPGMC)
%6.      'median'    --- weighted center of mass distance (WPGMC)
%7.      'ward'      --- inner squared distance (min variance algorithm)

%..Colunas da Matriz de inconsist�ncia
% 1. M�dia das alturas de todos os enlaces incluidos no calculo. 
% 2. Desv�o padr�o da coluna 1
% 3. N�mero de enlaces incluidos no c�lculo 
% 4. Coeficiente de inconsist�ncia. (altura-media)/desv�o -> (3raCol Z - 1ra I)/(2da I) = 4ta I



% MDist = {'euclidean','seuclidean','cityblock','minkowski','chebychev','mahalanobis','cosine','correlation','spearman','hamming','jaccard'};
% MAgru = {'single','complete','average','weighted','centroid','median','ward'};
%[VetorClasseSaida,Z,c,I] = fClusteringHierarquico(X,3,MDist{1},MAgru{1}); c

