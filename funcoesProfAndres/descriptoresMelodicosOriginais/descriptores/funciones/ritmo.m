%..Extrae el vector con los valores de las figuras rítmicas de la matriz de
%notas. 
function r = ritmo(nmat);

N = length(nmat);
r = intervalos(nmat(:,1));
r(N)= round(nmat(N,2) + nmat(N,1)) - nmat(N,1);

