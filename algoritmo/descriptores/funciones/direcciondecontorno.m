%..direccion de contorno ascendente y descendente

%..vector de notas escalado a una octava
%P=[2 4 3 7 6 9 12 4 6 7 4 9];

function [dca,dci,dcd]=direcciondecontorno(nmat);

%..Se extrae la columna de Pitch
P = mod(pitch(nmat)',12);
n = length(P);
I = diff(P);

%...contar los intervalos ascendentes y descendentes
Ia = 0; %..intervalos ascendentes
Ii = 0; %..intervalos iguales
Id = 0; %..intervalos descendentes

for i=1:n-1
    if I(1,i)>0
        Ia=Ia+1; 
    else
       if I(1,i)==0
         Ii=Ii+1;    
       else
         Id=Id+1;   
       end
    end
end

%..Calcular las densidades
dca = Ia/(n-1); %..densidad de intervalos ascendentes
dci = Ii/(n-1); %..densidad de intervalos iguales
dcd = Id/(n-1); %..densidad de intervalos descendentes

