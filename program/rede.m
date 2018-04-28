function matriz_adjacencia = rede(x,matra)
 up_x=x+1;
 
  for i=1:11
    matra(up_x(i),up_x(i+1))+=1;
  endfor

  matriz_adjacencia=matra;
endfunction