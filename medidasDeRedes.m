function saida = medidasDeRedes(serie, ordem)

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