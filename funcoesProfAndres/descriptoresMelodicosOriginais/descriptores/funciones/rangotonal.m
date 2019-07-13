%..Rango tonal
%..Descriptor estadístico de la melodía #2
%..
%..Entrada: P, vector de notas
%..Salida: rango tonal Tr
%.         Tr=max(P)-min(P)
%.
%..Andrés Eduardo Coca S.
%..

%..OJO función ambitus del toolbox midi, rango en semitonos

function Tr=rangotonal(nmat);

%..Se extrae la columna de Pitch
P = pitch(nmat)';

Tr=max(P)-min(P);

