%...intensidad del climax


function Iclimax = intensidaddelclimax(nmat);

%..vector de notas escalado a una octava
%P=[2 4 3 7 6 9 12 4 6 7 12 9];

P = pitch(nmat);
n = length(P);

%..se halla el vector de intervalos
P = mod(P,12);

%..hallar la nota clim�tica, la m�s alta
c=max(P);

%..contar el n�mero de veces que se encuentra la nota clim�tica
nc=0;
for i=1:n
    if P(i)==c
        nc=nc+1;
    end
end

%..hallar la intensidad del climax
Iclimax=1/nc;


