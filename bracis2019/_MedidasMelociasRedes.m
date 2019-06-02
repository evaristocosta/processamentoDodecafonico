clc
close all;
clear all;

%S = randperm(12)-1; %..s�rie aleat�ria
%S = [6 5 10 0 3 7 4 11 2 1 8 9]; 
%S = [3 0 4 2 7 6 10 9 5 8 11 1];
%S = [6 5 9 8 7 2 0 3 4 1 11 10];
S = [0 1 2 3 4 5  6 7 8 9 10 11]; %...escala crom�tica, falhou Td = 1, deve ser 0; e freqM =10 deve ser 11, 
%S = [0 6 1 7 2 8 3 9 4 10 5 11 6];

S = [4 1 5 3 8 7 11 10 6 0 9 2]; %..grau entrada ~= grau sa�da, resultados diferentes, iGO(1)<iGI(1)->(5,6)
     
IS = intervalos(S);

[M,Vu] = fcrearmatrizadj(IS);

%..arrumar a matriz com os n�s na ordem ascendente -11..11
          L = length(Vu);
         M2 = zeros(L,L); 
         M3 = M2;
[Vuasc,ind] = sort(Vu,'ascend');
for i=1:L
    M2(i,:) = M(ind(i),:);  %..ordenar as linhas
end
for i=1:L
    M3(:,i) = M2(:,ind(i)); %..ordenar as colunas
end
%..........................................................................

%..padronizar a n�s -11 a 11 = total 22 n�s................................
%NosIntervalos = -11:1:11;  %..est� incluso o 0
NosIntervalos = [-11:1:-1 1:1:11];  %..n�o est� incluso o 0
MT = zeros(22,22);

for i=1:L
    a = find(Vuasc(i)==NosIntervalos);
    for j=1:L
        b = find(Vuasc(j)==NosIntervalos);
        MT(a,b) = M3(i,j);
    end
end
figure(1) 
spy(MT)
%..........................................................................

%....C�lculo da tessirutra interv�lica.....................................
   GrauO = sum(MT,1);                  %..graus de sa�da (somat�rio das linhas) da matriz padronizada, cont�m grau =0
   GrauI = sum(MT,2);                  %..graus de entrada (somat�rio das colunas) da matriz padronizada, cont�m grau =0
 GrausPO = find(GrauO>=1);             %..�ndices dos graus positivos do grau de Sa�da
 GrausPI = find(GrauI>=1);             %..�ndices dos graus positivos dos grau de Entrada
     TaO1 = NosIntervalos(GrausPO(end)); %..Tessitura interv�lica asc.  = o n� do �ltimo (na ordem -11 a 11) grau de sa�da ou entrada
     TdO1 = NosIntervalos(GrausPO(1));   %..Tessitura interv�lica desc. = o n� do primeiro grau s/e
     TaI2 = NosIntervalos(GrausPI(end)); %..Tessitura interv�lica asc.  = o n� do �ltimo (na ordem -11 a 11) grau de sa�da ou entrada
     TdI2 = NosIntervalos(GrausPI(1));   %..Tessitura interv�lica desc. = o n� do primeiro grau s/e

     %...calculada com os n�s...................................................
   [a,b] = sort(Vu);
     Ta0 = a(end);
     Td0 = a(1);
     
G = [GrauI';  GrauO];     
%..para nao calcular vetor dentro de vetor, Eq. linear a tramos para a rela��o inteiros com valores intervalos
x1 = GrausPO(end);
TaO = fIndiceNo2Intervalo(x1)
x1 = GrausPO(1);
TdO = fIndiceNo2Intervalo(x1)

x2 = GrausPI(end);
TaI = fIndiceNo2Intervalo(x2)
x2 = GrausPI(1);
TdI = fIndiceNo2Intervalo(x2)


x3a = max(GrausPI(end),GrausPO(end));
Ta = fIndiceNo2Intervalo(x3a)
x3d = min(GrausPI(1),GrausPO(1));
Td = fIndiceNo2Intervalo(x3d)
%..........................................................................

TI = Ta-Td;  %..Maior Diferen�a Interv�lica
%..........................................................................

%................moda e frequencia modal...................................
%...moda: o n� que tem o m�ximo grau
%...freq. modal: o grau da moda
[freqModaO,modaO] = max(GrauO); 
MO = fIndiceNo2Intervalo(modaO)

[freqModaI,modaI] = max(GrauI);
MI = fIndiceNo2Intervalo(modaI)
%..........................................................................


fim = 1;