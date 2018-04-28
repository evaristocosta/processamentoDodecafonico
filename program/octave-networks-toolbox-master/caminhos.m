function [mtr1,mtr2,mtr3] = caminhos(x)
elem=(max(max(x))-1)/3;
mtr1=mtr2=mtr3=zeros(12,12);

for i=1:12
  for j=1:12
    if(x(i,j)>(elem*2))
      mtr1(i,j)+=1;
    endif
  endfor
endfor

for i=1:12
  for j=1:12
    if(x(i,j)<(elem*2)&&x(i,j)>=(elem))
      mtr2(i,j)+=1;
    endif
  endfor
endfor

for i=1:12
  for j=1:12
    if(x(i,j)<elem)
      mtr3(i,j)+=1;
    endif
  endfor
endfor

endfunction