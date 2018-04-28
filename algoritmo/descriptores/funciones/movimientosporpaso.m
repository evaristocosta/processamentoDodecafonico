%...movimientos por paso

function Mpp = movimientosporpaso(nmat);

%P=[2 4 4 5 7 8 7 9 9 9 12 0 9 9 9 8 7 6 4 3];
%P=[2 3 2 3 2 3 2 3 4 3 1 2 3 4 3 2 1];

P = mod(pitch(nmat)',12);

I = abs(diff(P));
n = length(I);

%..Cantidad de intervalos por paso diatónicos.........
idiat = 0; 
for i=1:n
    if (abs(I(1,i))==1) || (abs(I(1,i))==2)
        idiat = idiat+1;
    end
end
%......................................................

%..Calcular el descriptor........
Mpp=idiat/n;
%................................


