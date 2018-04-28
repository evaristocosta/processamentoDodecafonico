

function  Ni = intervalos2nombres(I);


switch I
    case 0,
        Ni = 'unísono';
        disp('Unísono')
    case 1,
        Ni = 'primera aumentada o segunda menor';
        disp('primera aumentada o segunda menor')
    case 2,
        Ni = 'segunda mayor';
        disp('segunda mayor')
    case 3,
        Ni = 'tercera menor';
        disp('segunda aumentada o tercera menor')
    case 4,
        Ni = 'tercera mayor';
        disp('Tercera mayor')
    case 5,
        Ni = 'cuarta justa';
        disp('Cuarta justa')
    case 6,
        Ni = 'quinta disminuida';
        disp('Cuarta aumentada o quinta disminuida')
    case 7,
        Ni = 'quinta justa';
        disp('Quinta justa')
    case 8,
        Ni = 'sexta menor';
        disp('Quinta aumentada o sexta menor')
    case 9,
        Ni = 'sexta mayor';
        disp('Sexta mayor')
    case 10,
        Ni = 'séptima menor';
        disp('Sexta aumentada o septima menor')
    case 11,
        Ni = 'séptima mayor';
        disp('Séptima mayor')
    otherwise
        Ni = 'error';
        disp('Error intervalos desconocido')
end
        