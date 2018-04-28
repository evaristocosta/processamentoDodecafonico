%..Halla el vector de intervalos de un vector de notas 

 function I=intervalos(P);

  n=length(P);

  %..se halla el vector de intervalos
  for i=1:n-1
      I(i)=P(i+1)-P(i);
  endfor
  endfunction