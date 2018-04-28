function serie_cell = abre_bd2()
%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'evaristo', '746136', 'Vendor', 'POSTGRESQL', 'Server', 'localhost', 'PortNumber', 5432);

%Read data from database.
curs = exec(conn, ['SELECT 	everything.num'...
    ' ,	everything.serie'...
    ' FROM 	"dodecaf"."public".everything ']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
serie_cell = curs.Data;

%serie_mat=cell2mat(serie_cell)
%a=serie_cell{1,2}

%Close database connection.
close(conn);

%Clear variables
clear curs conn

end