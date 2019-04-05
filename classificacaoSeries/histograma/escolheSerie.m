function serie = escolheSerie(num)

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, ['SELECT 	everything.serie'...
    ' FROM 	`dodecaf`.everything '...
    ' WHERE 	everything.num = ' num2str(num)]);

curs = fetch(curs);
close(curs);

%Assign data to output variable
serie_esc = curs.Data;
serie_mat=serie_esc{1};
serie=str2num(serie_mat);

%Close database connection.
close(conn);

%Clear variables
clear curs conn

end