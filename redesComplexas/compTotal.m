%SELECT `compositor`, COUNT(`compositor`) FROM `everything` GROUP BY `compositor` HAVING COUNT(`compositor`) > 5

function [redes_medidas, redes_clust] = compTotal(salva, desenha)

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, ['SELECT everything.compositor, COUNT(everything.compositor)'...
    ' FROM `dodecaf`.everything GROUP BY everything.compositor HAVING COUNT(everything.compositor) > 2']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
compositores = curs.Data;

redes_medidas = cell(length(compositores),14);
redes_clust = cell(length(compositores),7);

for i=1:length(compositores)
    %Matriz é refeita em cada iteração, para cada compositor
    matriz_base = zeros(22);
    
    %Add '' ao nome p/ pesquisa no BD
    nome_comp_org = compositores{i,1};
    q = char(39);
    nome_comp = strcat(q, nome_comp_org, q);
    
    %curs = exec(conn, ['SELECT 	everything.serie FROM `dodecaf`.everything WHERE 	everything.compositor = ' nome_comp]);
    curs = exec(conn, ['SELECT 	everything.serie FROM `dodecaf`.everything WHERE 	everything.compositor = ''Igor Stravinsky''']);
    curs = fetch(curs);
    close(curs);
    serie = curs.Data;
    
    qtde_comp=compositores{i,2};
    
    %Soma as matrizes de adjacencia de intervalos 
    for j=1:qtde_comp
        serie_num=str2num(serie{j});
        interv = diff(serie_num);
        matriz_base = matriz_base + intervalo_matriz_total(interv);
    end
    
    if desenha == 1
        figure(i)
        drawCircGraph(matriz_base) 
    end
    
    %Calcula as medidas da rede analizada
    [IW, raio, diametro, eficiencia, ma, MKin, MKout, MKtot, MSin, MSout, MStot, r0] = MedidasDeRedes(matriz_base);
    CD = fCoeficienteClusteringRedeDirecionada(matriz_base);
    CDzeros = tranfCD(CD);
    coef = mean(CDzeros(:,1));
    coefCycle = mean(CDzeros(:,2));
    coefMiddleman = mean(CDzeros(:,3));
    coefIn = mean(CDzeros(:,4));
    coefOut = mean(CDzeros(:,5));
    
    %Cria código único p/ cada compositor
    code = mean(mean(dec2hex(nome_comp)));
    code_comp = round(code*code*3)+i+qtde_comp;
    
    %Guarda resultados p/ posterior adição no BD
    redes_medidas(i,1:15) = {code_comp,nome_comp_org,qtde_comp,IW,raio,diametro,eficiencia,ma,MKin,MKout,MKtot,MSin,MSout,MStot,r0};
    redes_clust(i,1:8) = {code_comp, nome_comp_org,qtde_comp, coef, coefCycle, coefMiddleman, coefIn, coefOut};
    
end

if salva == 1
    %Salva no banco
    colname_medidas = {'codigo','compositor','qtde_composicoes','IW','raio','diametro','eficiencia','ma','MKin','MKout','MKtot','MSin','MSout','MStot','r0'};
    colname_clust = {'codigo','compositor','qtde_composicoes','coef','coefCycle','coefMiddleman','coefIn','coefOut'};

    table_medidas = 'medidas_de_rede';
    table_clust = 'coeficientes_clustering';

    datainsert(conn,table_medidas,colname_medidas,redes_medidas);
    datainsert(conn,table_clust,colname_clust,redes_clust);

    %Close database connection.
    close(conn);

    %Clear variables
    clear curs conn
end

end

function CDzeros = tranfCD(CDe)
CDzeros = zeros(22,5);

for x=1:5
    for y=1:22
       if isnan(CDe(y,x)) || isinf(CDe(y,x))
           CDzeros(y,x) = 0;
       else
           CDzeros(y,x) = CDe(y,x);
       end
    end   
end

end