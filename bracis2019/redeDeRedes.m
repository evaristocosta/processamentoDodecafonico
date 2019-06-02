function saida = redeDeRedes(serie, ordem, marcador, salva)

qtdeNos = length(ordem);

% P/ cada série usada
for qtde = 1:qtdeNos
    % Salva serie orginal
    serieAlt = serie;
    
    % Qual forma da série
    opt = ordem{qtde}(1);
    % Qual altura
    num = str2num(strcat(ordem{qtde}(2),ordem{qtde}(3)));
    
    intr = -diff(serieAlt);
    
    % Executa opção
    if opt == 'r'
        serieAlt = fliplr(serieAlt);
    elseif opt == 'i'
        serieAlt = cumsum([serieAlt(1) intr]);
        serieAlt = mod(serieAlt+12,12);
    elseif opt == 'q' % 'q' para retrograda invertida (ri)
        serieAlt = cumsum([serieAlt(1) intr]);
        serieAlt = mod(serieAlt+12,12);
        serieAlt = fliplr(serieAlt);
    end
    
    % Altera de acordo com altura
    [descritivos, geral, estatisticos] = medidasIndividual(mod(serieAlt+num,12));
    
    %estrutura.titl = ordem(qtde)';
    estrutura.desc = descritivos';
    estrutura.ger = geral';
    estrutura.est = estatisticos';
    
    %tudo = [estrutura.titl; estrutura.desc; estrutura.ger; estrutura.est];
    medidas = [estrutura.desc; estrutura.ger; estrutura.est];
    
    saida(:,qtde) = medidas;
    
end


% faz grafo da ordem
ordem = string(ordem);
for i = 1:(qtdeNos-1)
    if ~(ismember(i, marcador))
        g1(i) = {strcat('|',ordem(i),'|')};
        g2(i) = {strcat('|',ordem(i+1),'|')};
    end
end

% remove valores vazios
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
h=figure();
% plot com pesos
plot(G,'EdgeLabel',G.Edges.Weight, 'LineWidth', 2*G.Edges.Weight, 'ArrowSize', 14, 'NodeColor', 'red')

if salva == 1
    nomeArq = 'algoritmos/redes/ordem.png';
    saveas(h,nomeArq);
end

% escreve .net pra Pajek
%A = adjacency(G);
% Adjacencia com pesos
nn = numnodes(G);
[g1,g2] = findedge(G);
A = sparse(g1,g2,G.Edges.Weight,nn,nn);

% nomeia os nos
nomesNos = string(G.Nodes.Name);
if salva == 1
    write_matrix_to_pajek(full(A), 'algoritmos/redes/ordem.net', 'weighted', true, 'directed', true, 'labels', nomesNos);
end


% mesmo procedimento pra todas as medidas
saida = cell2mat(saida);    
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

end