%SELECT `compositor`, COUNT(`compositor`) FROM `everything` GROUP BY `compositor` HAVING COUNT(`compositor`) > 5

function [histFinal, intrv_ord] = somaHistcount()

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
    ' WHERE 	everything.compositor LIKE ''Igor %''']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
arnold = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn


histFinal = zeros(1,23);
intrv_ord = zeros(19,11);
for n=1:19
    serie_mat=arnold{n,2};
    serie_num=str2num(serie_mat);
    
    intervalos = diff(serie_num);
    normal = normalizaHistcounts(intervalos);
    
    intrv_ord(n,:) = sort(intervalos);
    
    histFinal = histFinal + normal;
end

end