function serie_cell = abre_bd()

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, ['SELECT 	everything.num'...
    ' ,	everything.serie'...
    ' FROM 	`dodecaf`.everything '...
    ' ORDER BY 	everything.num ASC ']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
serie_cell = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn

end