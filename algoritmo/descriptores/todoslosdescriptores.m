%TD = [dasc digu ddes EC ECP ECN ECC CT ID Iclimax MP RT sr VT];
%m1 = readmidi('escaladomayorblancas.mid');

function TD = todoslosdescriptores(nmat)

%1.2.3%..densidad de contorno ascedente, igual y ascendente - revisado
%[dasc,digu,ddes]=direcciondecontorno(nmat);

%4.5.6.7%..estabilidad del contorno - revisado
%..Proporción de intervalos en igual dirección segudios
%[EC,ECP,ECN,ECC]=estabilidaddelcontorno(nmat);

%8.%..centrado de tonalidad - revisado
%..proporción de veces que la tonica o la dominante se ejecutan con la figura de menor duración
CT = centradodetonalidad(nmat);

%9.%..intervalos disonantes - revisado pero falta mejorar
ID = intervalosdisonantes(nmat);

%10.%..intensidad del climax - revisado
Iclimax = intensidaddelclimax(nmat);

%11.%..movimientos por paso - revisado
%MP = movimientosporpaso(nmat);

%12.%..rango tonal - revisado
%RT = rangotonal(nmat); %..falta revisar resultado

%13.%..saltos de retorno - revisado
%sr = saltosderetorno(nmat);

%14.%..variedad tonal - revisado
%VT = variedadtonal(nmat);

% %15.16.17.%..Complijidad basada en la experanza
% %  Valores altos = alta complejidad
% %  coleccion de Essen media 5, desv. 1.
% cbmp = complebm(nmat,'p');
% cbmr = complebm(nmat,'r');
% cbmo = complebm(nmat,'o');
% %18.%..medida de originalidad melódica - valores altos indican alta
% %originalidad melódica 0 y 10
% mom = compltrans(nmat);
% %19.%..grado de melodiosidad - valores bajos indican alta melodiosidad.
% gm = gradus(nmat);

%..Vector con todos los descriptores
%      1    2    3   4   5   6   7  8  9     10   11 12 13 14 15   16   17  18   19      
%TD = [ddes digu dasc ECN ECC ECP EC CT ID Iclimax MP RT sr VT cbmp cbmr cbmo mom gm];
%TD = [dasc digu ddes EC CT ID Iclimax MP RT sr VT cbmp cbmr cbmo mom gm];
%TD = [EC CT ID Iclimax MP sr VT cbmp cbmr cbmo mom gm];
%TD = [VT dasc ddes digu ID EC MP];
TD = [CT ID Iclimax];
%......1  2  3    4     5  6  7   8    9    10  11  12
%TD = [cbmp cbmr cbmo mom gm];

