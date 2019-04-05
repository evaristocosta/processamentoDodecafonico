%..Rango tonal
%..Descriptor estad�stico de la melod�a #2
%..
%..Entrada: P, vector de notas
%..Salida: rango tonal Tr
%.         Tr=max(P)-min(P)
%.
%..Andr�s Eduardo Coca S.
%..

%..OJO funci�n ambitus del toolbox midi, rango en semitonos

function Tr=rangotonal(nmat);

%..Se extrae la columna de Pitch
P = pitch(nmat)';

Tr=max(P)-min(P);

