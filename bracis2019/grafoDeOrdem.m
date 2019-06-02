function saida = grafoDeOrdem(ordem, nomeEntrada, salva)

qtdeNos = length(ordem);

% faz grafo da ordem
ordem = string(ordem);
for i = 1:(qtdeNos-1)
    g1(i) = {strcat('|',ordem(i),'|')};
    g2(i) = {strcat('|',ordem(i+1),'|')};
end

g1 = g1(~cellfun('isempty',g1));
g2 = g2(~cellfun('isempty',g2));

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
%h=figure();
% plot com pesos
plot(G,'EdgeLabel',G.Edges.Weight, 'LineWidth', 2*G.Edges.Weight, 'ArrowSize', 14, 'NodeColor', 'red')

% escreve .net pra Pajek
%A = adjacency(G);
% Adjacencia com pesos
nn = numnodes(G);
[g1,g2] = findedge(G);
W = sparse(g1,g2,G.Edges.Weight,nn,nn);

nomesNos = string(G.Nodes.Name);

nomeCaminho = 'algoritmos/redes/ordem';
nomeRede = strcat(nomeCaminho,nomeEntrada,'.net');
%nomeFoto = strcat(nomeCaminho,nomeEntrada,'.png');

if salva == 1
%    saveas(h,nomeFoto);
    write_matrix_to_pajek(full(W), nomeRede, 'weighted', true, 'directed', true, 'labels', nomesNos);
end
saida=W;

end