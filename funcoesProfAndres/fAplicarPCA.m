%..função que cálcula PCA e devolve as medidas reduzidas (componentes) para o limiarPCA dado

function [medidasR,VarCum,score,proportion_of_variance] = fAplicarPCA(medidas,LimiarPCA);

          [n,nColB] = size(medidas);
    %[coeff,score,eigenvalues,tsquared,explained] = princomp(medidas);
    
    [coeff,score,explained,tsquared] = princomp(medidas);
    
                  VarCum = cumsum(var(score)) / sum(var(score));
    
                 NumComp = max(find(VarCum<LimiarPCA))+1;
                 if length(NumComp)==0
                     NumComp = max(find(VarCum<1))+1;
                 end
                      Bc = coeff(:,nColB-NumComp+1:nColB);
                      Yc = medidas*Bc;
                medidasR = Yc;
                
  proportion_of_variance = explained;
                             
           