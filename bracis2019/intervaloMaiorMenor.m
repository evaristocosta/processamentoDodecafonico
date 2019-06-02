function [M, m] = intervaloMaiorMenor(L, C)

% encontra maior intervalo
Mnci = find(C, 1, 'last' );
Mnli = find(L, 1, 'last' );
M = max([Mnci Mnli]) - 12;

% encontra menor intervalo
mnci = find(C, 1);
mnli = find(L, 1);
m = min([mnci mnli]) - 12;

end