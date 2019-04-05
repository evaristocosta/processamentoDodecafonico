function mtrx_result = somador_matriz(cell_array)

mtrx_result = zeros(22);

for i=1:19
   serie_mat=cell_array{i,1};
   serie_num=str2num(serie_mat); 
   sI = diff(serie_num);
   
   mtrx_result = mtrx_result + intervalo_matriz_total(sI);
   
end

end