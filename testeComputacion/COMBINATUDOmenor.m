function [todosErros, adaErrokFold] = COMBINATUDOmenor()
addpath('adaboost/');

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'numeric');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);



%Vetor de classes
tamanhoClasses = [19 19]; 
numClasses = size(tamanhoClasses,2);
classes = [];
for i=1:numClasses
    classesi = zeros(tamanhoClasses(i),1) + i-1;
    classes = [classes; classesi];
end
classes(1:19)= -1;


comb = 1:27;
queryCell = {' , descritivos.id',' , descritivos.ec',' , descritivos.ecp',' , descritivos.ecn',' , descritivos.mpp',...
    ' , descritivos.dca',' , descritivos.dcd',' , descritivos.lr',' , estatisticos.m_artm',' , estatisticos.dsv_p',...
    ' , estatisticos.moda',' , estatisticos.frq_moda',' , estatisticos.mais_moda',' , estatisticos.assmtr',...
    ' , estatisticos.m_artmN',' , estatisticos.dsv_pN',' , estatisticos.modaN',' , estatisticos.frq_modaN',...
    ' , estatisticos.mais_modaN',' , estatisticos.assmtrN',' , estatisticos.m_ponderada',' , estatisticos.desv_p_ponderado',...
    ' , gerais.intrv_maior',' , gerais.intrv_menor',' , gerais.diff_intrv',' , gerais.intrv_maiorN',' , gerais.diffFL'};
queryStr = string(queryCell);

for qtde=5:11
    quant = num2str(qtde);
    arq = strcat('todosErrosDo',quant,'.txt');
    
    c = combnk(comb,qtde);
    [prof,tam] = size(c);
    for i=52678:52778
        query = ' ';
        for j=1:tam
            query=strcat(query,queryStr(c(i,j)));
        end

        queryIn = char(query);
        queryIn(2) = [];
        curs = exec(conn, ['SELECT' queryIn ' FROM   (  (  ( `dodecaf`.descritivos '...
        ' INNER JOIN `dodecaf`.gerais '...
        ' ON 	descritivos.num = gerais.num )'...
        ' INNER JOIN `dodecaf`.estatisticos '...
        ' ON 	descritivos.num = estatisticos.num )'...
        ' INNER JOIN `dodecaf`.everything '...
        ' ON 	descritivos.num = everything.num )'...
        ' WHERE 	everything.compositor LIKE ''Arnold%'''...
        ' OR 	everything.compositor LIKE ''Igor%''']);

        curs = fetch(curs);
        close(curs);

        %Assign data to output variable
        medidasR = curs.Data;


        [classestimate,model]=adaboost('train',medidasR,classes,30);
        errorAda=zeros(1,length(model)); 
        for x=1:length(model)
            errorAda(x)=model(x).error; 
        end 
        todosErros(i,qtde) = errorAda(length(errorAda));

        adaErrokFold(i,qtde) = kfoldAda(medidasR,classes);

        %Salva em arquivo      
        fileID = fopen(arq,'a');
        erroDeUm = char(num2str(todosErros(i,qtde)));
        errokFold = char(num2str(adaErrokFold(i,qtde)));
        classeResult = char(num2str(classestimate'));
        fprintf(fileID,'====   ');
        fprintf(fileID,queryIn);
        fprintf(fileID,'   ====\nErro Singular: '); 
        fprintf(fileID,erroDeUm);
        fprintf(fileID,'\nErro com kFold: ');
        fprintf(fileID,errokFold);
        fprintf(fileID,'\nClasse Treinada: ');
        fprintf(fileID,classeResult);
        fprintf(fileID,'\n\n');
        fclose(fileID);
    end
end
%Close database connection.
close(conn);

%Clear variables
clear curs conn
end