%..função para calcular o indice kappa de uma matriz de confusão

%..para binária
% a = cm(1,1); b=cm(1,2); c=cm(2,1); d=cm(2,2);
% pe=(((a + b)*(a + c)) + ((c + d)*(b + d)))/((a + b + c + d)^2);
% po =(a+d)/(a + b + c + d);
% kappa=(po-pe)/(1-pe)

function [IndiceKappa,varKappa] = fIndiceKappa(MatrizConfusao)
  
%MatrizConfusao = [31 4 2;6 29 8;10 7 3]; %...ejemplo do livro pag. 565

   MC = MatrizConfusao;
    N = sum(sum(MC));
teta1 = sum(diag(MC))/N;
teta2 = sum((sum(MC,1).*sum(MC,2)')/N)/N;
IndiceKappa = (teta1 - teta2)/(1-teta2);

NumClases = length(MC);
ConfusionMatrix = MC;
% Compute Overall Accuracy and Cohen's kappa statistic
n      = sum(ConfusionMatrix(:));                     % Total number of samples
PA     = sum(diag(ConfusionMatrix)); %..teta1 * N
OA     = PA/n; %..igual a teta1

% Estimated Overall Cohen's Kappa (suboptimal implementation)
npj = sum(ConfusionMatrix,1);
nip = sum(ConfusionMatrix,2);
PE  = npj*nip;
if (n*PA-PE) == 0 && (n^2-PE) == 0
    % Solve indetermination
    %warning('0 divided by 0')
    Kappa = 1;
else
    Kappa  = (n*PA-PE)/(n^2-PE);
end

% Cohen's Kappa Variance
theta1 = OA;
theta2 = PE/n^2;
theta3 = (nip'+npj) * diag(ConfusionMatrix)  / n^2;

suma4 = 0;
for i=1:NumClases
    for j=1:NumClases
        suma4 = suma4 + ConfusionMatrix(i,j)*(nip(i) + npj(j))^2;
    end;
end;
theta4 = suma4/n^3;
varKappa = ( theta1*(1-theta1)/(1-theta2)^2     +     2*(1-theta1)*(2*theta1*theta2-theta3)/(1-theta2)^3      +     (1-theta1)^2*(theta4-4*theta2^2)/(1-theta2)^4  )/n;
Z = Kappa/sqrt(varKappa);
CI = [Kappa + 1.96*sqrt(varKappa), Kappa - 1.96*sqrt(varKappa)];
        
