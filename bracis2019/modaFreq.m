function [moda, freq] = modaFreq(L, C)

% encontra frequencia
freq = max([L C]);

% verifica em qual vetor está a frequencia e define a moda
if sum(ismember(L, freq))
    moda = find(L==freq, 1)-12;
else
    moda = find(C==freq, 1)-12;
end

end