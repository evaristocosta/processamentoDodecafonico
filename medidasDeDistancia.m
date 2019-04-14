function medidasDistancia = medidasDeDistancia(ser, ord)

medidas = medidasDeRedes(ser,ord);
medidas = cell2mat(medidas);

[coeff,score,latent] = pca(medidas');

plot(score(:,1),score(:,2))

distancias(1:2,:) = score(:,1:2)';

medidasNome = {'euclidean';'squaredeuclidean';'seuclidean';'cityblock';'minkowski';'chebychev';'cosine';'correlation';'hamming';'jaccard';'spearman'};
medidasValores = [pdist(distancias, 'euclidean');pdist(distancias, 'squaredeuclidean');pdist(distancias, 'seuclidean');pdist(distancias, 'cityblock');pdist(distancias, 'minkowski');pdist(distancias, 'chebychev');pdist(distancias, 'cosine');pdist(distancias, 'correlation');pdist(distancias, 'hamming');pdist(distancias, 'jaccard');pdist(distancias, 'spearman')];

medidasDistancia = table(medidasNome,medidasValores);

end