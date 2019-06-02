function [nos, A, W] = grafoDeOrdemSimplificado(ordem)

qtdeNos = length(ordem);

% faz grafo da ordem
ordem = string(ordem);
for i = 1:(qtdeNos-1)
    g1(i) = {ordem(i)};
    g2(i) = {ordem(i+1)};
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
nos = G.Nodes.Name;
A = G.adjacency;

% Adjacencia com pesos
nn = numnodes(G);
[g1,g2] = findedge(G);
W = sparse(g1,g2,G.Edges.Weight,nn,nn);

end