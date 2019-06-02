function medidas = medidasDeDerivadas(serie, ordem)

[nos, A, W] = grafoDeOrdemSimplificado(ordem);

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
    medidas(1:15,qtde) =  medidasDerivadaIndividual(mod(serieAlt+num,12));
    
    medidas(16:18,qtde) = medidasNoLocal(A,W,nos,ordem(qtde));
end

medidas = cell2mat(medidas);

end