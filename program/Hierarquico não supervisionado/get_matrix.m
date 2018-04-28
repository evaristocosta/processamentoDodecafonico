fileID=fopen('/home/evaristo/Área de Trabalho/asd.txt','r');
formatSpec='%f %f %f %f %f %f %f';
sizeA=[7 Inf];
A=fscanf(fileID,formatSpec,sizeA);
A=A';