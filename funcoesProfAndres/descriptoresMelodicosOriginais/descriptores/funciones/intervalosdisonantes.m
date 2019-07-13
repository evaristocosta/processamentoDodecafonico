%..Intervalos disonantes  
%..Descriptor estadístico de la melodía #
%..
%..Id= #intervalos disonantes / notas-1
%..intervalos consonantes perfectos o imperfectos
%..disonancia absoluta o diatonicas y condicionales o cromáticas
%..
%..consonancia perfecta: 8-5-4 justas
%..    ''   imperfectas: 3 - 6 M y m
%..disonancia absoluta o diatónica: 2 mayor (2 st), 2 menor (1 st)- 
%                                   7 mayor (11 st), 7 menor (10 st) y
%.                                  y sus enarmónicos (3 dism, 3 doble dism, 7 mayor, 7 aum)
%..        condicional o cromática: 3-4-5-7 aum, 4-5 doble aum. 
%           se debe conocer la escala y el intervalo de las notas no
%           pertenecientes a la escala para saber las alteraciones

%..vector de notas escalado a una octava

function pid = intervalosdisonantes(nmat);

%P = [1 2 0 11 6 1 3 4 0 10 11 1];

P = mod(pitch(nmat)',12);

%..se halla el vector de intervalos
I = abs(diff(P)); %..se halla el valor absoluto de I porque no importa la dirección del intervalos
n = length(I);

%..se halla la cantidad de intervalos disonantes
id=0;
for i=1:n
   if (I(i)==1)||(I(i)==6)||(I(i)==10)||(I(i)==11)
      id=id+1;
   end
end

%..proporción de intervalos disonantes
pid=id/n;



