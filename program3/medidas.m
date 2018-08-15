function [medidasR, classes] = medidas(ver)
%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'numeric');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

switch ver
    case 'old'
        %Read data from database.
        curs = exec(conn, ['SELECT descritivos.id'...
            ' ,	descritivos.ec'...
            ' ,	descritivos.mpp'...
            ' ,	descritivos.dca'...
            ' ,	gerais.intrv_maiorN'...
            ' ,	gerais.diff_intrv'...
            ' ,	gerais.diffFL'...
            ' ,	estatisticos.frq_moda'...
            ' ,	estatisticos.mais_moda'...
            ' ,	estatisticos.moda'...
            ' ,	estatisticos.assmtr'...
            ' ,	estatisticos.m_ponderada'...
            ' ,	estatisticos.desv_p_ponderado'...
            ' FROM 	 (  (  ( `dodecaf`.descritivos '...
            ' INNER JOIN `dodecaf`.gerais '...
            ' ON 	descritivos.num = gerais.num )'...
            ' INNER JOIN `dodecaf`.estatisticos '...
            ' ON 	descritivos.num = estatisticos.num )'...
            ' INNER JOIN `dodecaf`.everything '...
            ' ON 	descritivos.num = everything.num )'...
            ' WHERE 	everything.compositor LIKE ''Arnold%'''...
            ' OR 	everything.compositor LIKE ''Igor%''']);
    case 'new'
        %Read data from database.
        curs = exec(conn, ['SELECT descritivos.id'...
            ' , descritivos.ecp'...
            ' , descritivos.ecn'...
            ' , descritivos.mpp'...
            ' , descritivos.dca'...
            ' , estatisticos.modaN'...
            ' , estatisticos.frq_modaN'...
            ' , estatisticos.mais_modaN'...
            ' , estatisticos.assmtrN'...
            ' , estatisticos.m_ponderada'...
            ' , estatisticos.desv_p_ponderado'...
            ' , gerais.diff_intrv'...
            ' , gerais.intrv_maiorN'...
            ' , gerais.diffFL'...
            ' FROM 	 (  (  ( `dodecaf`.descritivos '...
            ' INNER JOIN `dodecaf`.gerais '...
            ' ON 	descritivos.num = gerais.num )'...
            ' INNER JOIN `dodecaf`.estatisticos '...
            ' ON 	descritivos.num = estatisticos.num )'...
            ' INNER JOIN `dodecaf`.everything '...
            ' ON 	descritivos.num = everything.num )'...
            ' WHERE 	everything.compositor LIKE ''Arnold%'''...
            ' OR 	everything.compositor LIKE ''Igor%''']);
    case 'all'
        curs = exec(conn, ['SELECT descritivos.id'...
            ' , descritivos.ec'...
            ' , descritivos.ecp'...
            ' , descritivos.ecn'...
            ' , descritivos.mpp'...
            ' , descritivos.dca'...
            ' , descritivos.dcd'...
            ' , descritivos.lr'...
            ' , estatisticos.m_artm'...
            ' , estatisticos.dsv_p'...
            ' , estatisticos.moda'...
            ' , estatisticos.frq_moda'...
            ' , estatisticos.mais_moda'...
            ' , estatisticos.assmtr'...
            ' , estatisticos.m_artmN'...
            ' , estatisticos.dsv_pN'...
            ' , estatisticos.modaN'...
            ' , estatisticos.frq_modaN'...
            ' , estatisticos.mais_modaN'...
            ' , estatisticos.assmtrN'...
            ' , estatisticos.m_ponderada'...
            ' , estatisticos.desv_p_ponderado'...
            ' , gerais.intrv_maior'...
            ' , gerais.intrv_menor'...
            ' , gerais.diff_intrv'...
            ' , gerais.intrv_maiorN'...
            ' , gerais.diffFL'...
            ' FROM 	 (  (  ( `dodecaf`.descritivos '...
            ' INNER JOIN `dodecaf`.gerais '...
            ' ON 	descritivos.num = gerais.num )'...
            ' INNER JOIN `dodecaf`.estatisticos '...
            ' ON 	descritivos.num = estatisticos.num )'...
            ' INNER JOIN `dodecaf`.everything '...
            ' ON 	descritivos.num = everything.num )'...
            ' WHERE 	everything.compositor LIKE ''Arnold%'''...
            ' OR 	everything.compositor LIKE ''Igor%''']);
    otherwise
            'erro';
end
       

curs = fetch(curs);
close(curs);

%Assign data to output variable
medidasR = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn

%Vetor de classes
tamanhoClasses = [19 19]; 
numClasses = size(tamanhoClasses,2);
classes = [];
for i=1:numClasses
    classesi = zeros(tamanhoClasses(i),1) + i-1;
    classes = [classes; classesi];
end

end