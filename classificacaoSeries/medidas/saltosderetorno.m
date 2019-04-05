%..Saltos de retorno
%..n�mero de saltos grandes (mayores o iguales a 8 semitonos) que no estan
%seguidos por un intervalo de retorno (m�nimo 1 semitono menor que el intervalo precedente)

%P=[2 4 4 5 7 8 7 9 9 9 12 0 9 9 9 8 7 6 4 3];
%P=[2 3 2 3 2 3 2 3 4 3 1 2 3 4 3 2 1];
%P=[2 2 2 11 3 2 2];

function Sr = saltosderetorno(I)

    %P = pitch(nmat)';
    %I = intervalos(P);
    n = length(I);
salto = 8; 

%..Cantidad de intervalos por paso diat�nicos.........
    il = 0;
  ilsr = 0; %..intervalos largos sin retorno
for i=1:n-1
    if (abs(I(i)) >= salto) 
           il = il+1;
    end
    
    if (abs(I(i)) >= salto) %..si el intervalos es mayor que 9
        if (I(i) >0) && (I(i+1) < 0) || (I(i) <0) && (I(i+1) > 0) %..si el siguiente tiene sentido contrario
           if (abs(I(i+1)) >= (abs(I(i))-1))
               ilsr = ilsr+1;
           end
        end
    end
end
%......................................................

%..Calcular el descriptor........
Sr = (n-ilsr)/n; % a mayor n�mero de intervalos de retorno, Sr es menor a 1.
%................................
