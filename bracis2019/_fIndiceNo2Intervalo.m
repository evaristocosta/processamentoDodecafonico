%...fun��o para converter de �ndice de n� (1 a 22) para intervalos (-11 a 11, sem 0)
%...usado no c�lculo da tessitura interv�lica

function y = fIndiceNo2Intervalo(x)


if x<=11
   y = x-12;
else
   y = x-11;
end