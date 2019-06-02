function [raio, ma, MKtot, MStot, r0, coef, coef_w] = mseletas(W)
[~, raio, ~, ~, ma, ~, ~, MKtot, ~, ~, MStot, r0] = MedidasDeRedes(W);

CD = fCoeficienteClusteringRedeDirecionada(W);
CDzeros = tranfCD(CD);

% coeficiente de clustering
coef = mean(CDzeros(:,1));
% coeficiente de clustering ponderado
coef_w = mean(weighted_clust_coeff(W));

end