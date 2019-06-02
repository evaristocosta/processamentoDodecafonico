function comp_matrx = geraMatrizComp(nome)

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, ['SELECT 	everything.serie FROM `dodecaf`.everything WHERE 	everything.compositor LIKE ' nome]);

curs = fetch(curs);
close(curs);

%Assign data to output variable
serie = curs.Data;

comp_matrx = zeros(23);

for j=1:length(serie)
    serie_num=str2num(serie{j});
    interv = diff(serie_num);
    comp_matrx = comp_matrx + intervalo_matriz_total(interv);
end

%Salva em arquivo
ext = '.txt';
arq = strcat(nome,ext);
fileID = fopen(arq,'w');

fprintf(fileID,nome);
fprintf(fileID,'\n\n');
formatSpec = '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d \n';
fprintf(fileID,formatSpec,comp_matrx);
fclose(fileID);

%Cria grafo
drawCircGraph(comp_matrx);

end