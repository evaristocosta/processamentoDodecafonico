function outra = redesDeMedidas(saida, marcador, salva)

qtdeNos = size(saida);
qtdeNos = qtdeNos(2);

for qtde = 1:27
    clear nomesNos;
    clear g1;
    clear g2;
    
    for i = 1:(qtdeNos-1)
        if ~(ismember(i, marcador))
            g1(i) = {strcat('|',num2str(saida(qtde,i)),'|')};
            g2(i) = {strcat('|',num2str(saida(qtde,i+1)),'|')};
        end
    end
    
    g1 = g1(~cellfun('isempty',g1));
    g2 = g2(~cellfun('isempty',g2));
    
    edgesString = string([g1(:), g2(:)]);
    
    [C,ia,ic] = unique(edgesString,'rows');
    a_counts = accumarray(ic,1);
    value_counts = [C, a_counts];
    
    edgesUnique = cellstr(value_counts);
    G = digraph(edgesUnique(:, 1), edgesUnique(:, 2), str2double(edgesUnique(:, 3)));
    
    %A = adjacency(G);
    % Adjacencia com pesos
    nn = numnodes(G);
    [g1,g2] = findedge(G);
    A = sparse(g1,g2,G.Edges.Weight,nn,nn);
    
    % nomeia os nos
    nomesNos = string(G.Nodes.Name);
    
    h=figure('visible','off');
    %plot(G);
    plot(G,'EdgeLabel',G.Edges.Weight, 'LineWidth', 2*G.Edges.Weight, 'ArrowSize', 14, 'NodeColor', 'red')

    if qtde < 9
        nomeArq = strcat('algoritmos/redes/desc',num2str(qtde),'.png');
    	nomeNet = strcat('algoritmos/redes/desc',num2str(qtde),'.net');
    elseif qtde < 14
        nomeArq = strcat('algoritmos/redes/ger',num2str(qtde),'.png');
    	nomeNet = strcat('algoritmos/redes/ger',num2str(qtde),'.net');
    else
        nomeArq = strcat('algoritmos/redes/est',num2str(qtde),'.png');
    	nomeNet = strcat('algoritmos/redes/est',num2str(qtde),'.net');
    end
    
    if salva == 1
        saveas(h,nomeArq);
        write_matrix_to_pajek(full(A), nomeNet, 'weighted', true, 'directed', true, 'labels', nomesNos);
    end
    
end

outra = 1;
end