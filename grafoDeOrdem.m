function saida = grafoDeOrdem(ordem)

qtdeNos = length(ordem);

% faz grafo da ordem
ordem = string(ordem);
for i = 1:(qtdeNos-1)
    g1(i) = {strcat('|',ordem(i),'|')};
    g2(i) = {strcat('|',ordem(i+1),'|')};
end


% remove duplicatas de lados
% (https://www.mathworks.com/matlabcentral/answers/84370-efficient-way-to-identify-duplicate-edges)
edgesString = string([g1(:), g2(:)]);

% adiciona pesos
% (https://www.mathworks.com/help/matlab/ref/unique.html#mw_42eea7c7-dde5-45e9-8434-133a1dfe4b6a)
[C,ia,ic] = unique(edgesString,'rows');
a_counts = accumarray(ic,1);
value_counts = [C, a_counts];

edgesUnique = cellstr(value_counts);
G = digraph(edgesUnique(:, 1), edgesUnique(:, 2), str2double(edgesUnique(:, 3)));


% escreve a figura e salva em arquivo
%h=figure('visible','off');
h=figure();
% plot com pesos
plot(G,'EdgeLabel',G.Edges.Weight, 'LineWidth', 2*G.Edges.Weight, 'ArrowSize', 14, 'NodeColor', 'red')
nomeArq = 'algoritmos/redes/ordem.png';
saveas(h,nomeArq);


% escreve .net pra Pajek
A = adjacency(G);
write_matrix_to_pajek(full(A), 'algoritmos/redes/ordem.net', 'weighted', true, 'directed', true);

saida=1;

end