function medidas = medidasNoLocal(A,W,nos,opcao)

graus = degrees(full(A));
forcas = degrees(full(W));

CDe = fCoeficienteClusteringRedeDirecionada(W);
CDzeros = zeros(length(CDe));
for y=1:length(CDe)
   if isnan(CDe(y)) || isinf(CDe(y))
       CDzeros(y) = 0;
   else
       CDzeros(y) = CDe(y);
   end
end   




% coeficiente de clustering
coef = CDzeros;
% coeficiente de clustering ponderado
coef_w = weighted_clust_coeff(W);

for i=1:length(nos)
   if(strcmp(opcao, nos(i)))
       medidas(1:3) = {graus(i), forcas(i), coef(i)};
       break;
   end
end




end