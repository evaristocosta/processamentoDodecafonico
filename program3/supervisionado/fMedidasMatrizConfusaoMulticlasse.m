function [accuracy,medidas,prevalence] = fMedidasMatrizConfusaoMulticlasse(MatrizConfusao)
M = MatrizConfusao;
% This fucntion evaluates the performance of a classification model by 
% calculating the common performance measures: Accuracy, Sensitivity, 
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input: ACTUAL = Column matrix with actual class labels of the training
%                 examples
%        PREDICTED = Column matrix with predicted class labels by the
%                    classification model
% Output: EVAL = Row matrix with all the performance measures

%REVOCA��O (RECALL) E PRECIS�O ( PRECISION)

%..disposi��o linhas:sa�da coluna:entrada

%M = [80 0 2 10; 10 50 8 5;0 0 70 5;10 0 0 100]; %..exemplos cachorros,coelhos, lobos, gatos
%M = [20 180;10 1820]; %..wiki
%M = [70 40;30 60];
% M = [5 3 0; 
%      2 3 1;
%     0 2 11];


c = length(M);

N = sum(sum(M));
tp = diag(M)';     %..True Positive and true negative
tn = zeros(1,c);
fp = tn;
fn = tn;
for i=1:c
  % tn(1,i) = sum(sum(fMatrizMenorComplementar(M,i,i))); %..True Negative
   fp(1,i) = sum(M(i,:))-M(i,i);                        %..False Positive
   fn(1,i) = sum(M(:,i))-M(i,i);                        %..False Negative
end

   accuracy = sum(tp)/N;        % Acur�cia propor��o classificados corretamente  Acur�cia = 1 � taxa de classifica��o incorreta
sensitivity = tp ./ (tp + fn);  % Sensibilidade, Recall: TPR = TP / (TP + FN)
%specificity = tn ./ (tn + fp);  % Especificidade:        TNR = TN / (FP + TN)
%        FPR = 1 - specificity;  % False positive rate (?) = type I error = 1 ? specificity = FP / (FP + TN) = 180 / (180 + 1820) = 9%
%        FPR = fp ./ (fp + tn);  % Taxa de FP:            FPR = FP / (FP + TN)
        FNR = 1 - sensitivity;  % False negative rate (?) = type II error = 1 ? sensitivity = FN / (TP + FN) = 10 / (20 + 10) = 33%
        FNR = fn ./ (fn + tp);  % Taxa de FN:            FNR = FN / (FN + TP)  
  precision = tp ./ (tp + fp);  % Precis�o ou PPV (Positive predictive value)            
%        NPV = tn ./ (tn + fn);  % Negative predictive value
        FDR = fp ./ (fp + tp);  %..false discovery rate
      power = 1 - FNR;          % power = sensitivity;  
  %      LRP = sensitivity ./ (1 - specificity); % Likelihood ratio positive = sensitivity / (1 ? specificity) = 66.67% / (1 ? 91%) = 7.4 
   %     LRN = (1 - sensitivity) ./ specificity; % Likelihood ratio negative = (1 ? sensitivity) / specificity = (1 ? 66.67%) / 91% = 0.37
 prevalence = (tp + fn) / N; 
   %   gmean = sqrt(sensitivity.*specificity);     %..geometric mean   
  f_measure = 2*((precision.*sensitivity)./(precision + sensitivity)); %..F-score is the harmonic mean of precision and recall=sensitivity

% REcall = Revoca��o %..igual a sensitivity en caso binario %;tn / (fn + tn);  %TN / (FN + TN)
%.. total Condition Positive (TP + FN)
%..total Condition Negative  (FP + TN)
%tp_rate = tp./(tp + tn);   %..Positive predictive value
%tn_rate = tn./ (tp + tn); %..
%..TPR + FNR = 1
%..TNR + FPR = 1

%            S              E          P        VPN    F-score
%............TPR           TNR        PPV       NPV             FPR  FNR        
%medidas = [sensitivity; specificity; precision; NPV; f_measure; FPR; FNR;      FDR; LRP; LRN; gmean]'; 

medidas = [sensitivity; precision; f_measure; FNR;FDR;]'; 
%..para o caso bin�rios ficam os valores cruzados, 
%..a sensibilidade da classe 1 = especificidade classe 2
%..a especificidade da classe 1 = sensibilidade classe 2
%..ent�o s� � necess�ria a primeira linha
