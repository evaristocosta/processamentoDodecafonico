function [descritivos, geral, estatisticos] = medidasIndividual(serie_num)
%addpath('medidas/');

intr = diff(serie_num);

%DESCRITIVOS
%Intervalos dissonantes
intrv_diss = intervalosdisonantes(intr);

%Perfil melódico
[dca,dcd] = direcciondecontorno(serie_num);

%Estabilidade de contorno
[EC,ECP,ECN] = estabilidaddelcontorno(serie_num);

%Movimentos por passo
Mpp = movimientosporpaso(intr);

%Leap Return
LR = saltosderetorno(intr);

descritivos(1:8)={intrv_diss,EC,ECP,ECN,Mpp,dca,dcd,LR};


%GERAIS
[M, m, diff_interv, MN, mN, diffFL, gerais, normais, m_pond, dsv_p_pond] = geraisNormais(serie_num);
geral(1:5)={M,m,diff_interv,MN,diffFL};


%ESTATÍSTICOS
media = gerais(1);
desvio = gerais(2);
moda = gerais(3);
freq = gerais(4);
outro = gerais(5);
assm = gerais(6);

mediaN = normais(1);
desvioN = normais(2);
modaN = normais(3);
freqN = normais(4);
outroN = normais(5);
assmN = normais(6);

estatisticos(1:14)={media,desvio,moda,freq,outro,assm,mediaN,desvioN,modaN,freqN,outroN,assmN,m_pond,dsv_p_pond};

end