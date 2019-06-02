%...função para converter de índice de nó (1 a 22) para intervalos (-11 a 11, sem 0)
%...usado no cálculo da tessitura interválica

function y = fIndiceNo2Intervalo(x)


if x<=11
   y = x-12;
else
   y = x-11;
end