clc

%....Leer nmats de las obras clásicas........
for i=1:25
    nmat{i} = readmidi([int2str(i) '.mid'])
end
%............................................

%.....Guardarlas en un archivo...............
save nmatobrasclasicas nmat
%load nmatobrasclasicas
%............................................

DM = zeros(25,19);

for i=1:25
  DM(i,:) = todoslosdescriptores(nmat{i});
end

