function intrv_diss = intervalos_diss(x)
I = abs(diff(x)); %..se halla el valor absoluto de I porque no importa la dirección del intervalos
n = length(I);

%..se halla la cantidad de intervalos disonantes
id=0;
for i=1:n
   if (I(i)==1)||(I(i)==6)||(I(i)==10)||(I(i)==11)
      id=id+1;
   end
end

%..proporción de intervalos disonantes
intrv_diss=id/n;


