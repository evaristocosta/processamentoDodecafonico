function [num,serie_mat] = abre_bd(conn,n)
%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
%conn = database('dodecaf', 'evaristo', '746136', 'Vendor', 'POSTGRESQL', 'Server', 'localhost', 'PortNumber', 5432);

%Read data from database.
curs = exec(conn, ['SELECT  everything.serie FROM "dodecaf"."public".everything where everything.num =' num2str(n)]);

   curs = fetch(curs);
close(curs);

%Assign data to output variable
serie_cell = curs.Data;

   %Abre dado do banco 
   % serie_cell = pq_exec_params (x, "select serie from everything where num=$1;",{n}).data;
    serie_mat=cell2mat(serie_cell);
    num=str2num(serie_mat);
    
    
%Close database connection.
close(conn);

%Clear variables
clear curs conn
   

end