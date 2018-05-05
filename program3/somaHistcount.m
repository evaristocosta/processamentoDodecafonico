%SELECT `compositor`, COUNT(`compositor`) FROM `everything` GROUP BY `compositor` HAVING COUNT(`compositor`) > 5

function [histFinal, intrv_ord] = somaHistcount(nome)

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

nome = strcat('''',nome,'%''');

%Read data from database.
curs = exec(conn, ['SELECT 	everything.num'...
    ' ,	everything.serie'...
    ' FROM 	`dodecaf`.everything '...
    ' WHERE 	everything.compositor LIKE ' nome]);

curs = fetch(curs);
close(curs);

%Assign data to output variable
series = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn


histFinal = zeros(1,23);
intrv_ord = zeros(19,11);
for n=1:19
    serie_mat=series{n,2};
    serie_num=str2num(serie_mat);
    
    intervalos = diff(serie_num);
    normal = normalizaHistcounts(intervalos);
    
    intrv_ord(n,:) = sort(intervalos);
    
    histFinal = histFinal + normal;
end
% figure;
%histFin = [histFinalA;histFinalI];
% x = [-11:11];
% b_h = bar(x,histFin');
% set(b_h(1), 'FaceColor', [0.8078    0.4392    0.3451])
% set(b_h(2), 'FaceColor', [0.3529    0.6078    0.8314])

end