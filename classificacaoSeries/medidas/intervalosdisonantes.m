 function pid = intervalosdisonantes(nmat);
  I = abs(nmat); %..se halla el valor absoluto de I porque no importa la direcci�n del intervalos
  n = length(I);

  %..se halla la cantidad de intervalos disonantes
  id=0;
  for i=1:n
     if (I(i)==1)||(I(i)==6)||(I(i)==10)||(I(i)==11)
        id=id+1;
     end
  end

  %..proporci�n de intervalos disonantes
  pid=id/n;
  
     end