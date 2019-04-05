%..Centrado de tonalida 
%..Descriptor estadístico de la melodía #3
%..
%..Tc=centradodetonalidad(vector pitch,vector de ritmo);
%..Tc=centradodetonalidad(nmat);

%P=[1 5 3 4 5 4 1 2 5 4 5 3 4];
%R=[2 1 4 5 6 7 1 5 1 9 8 7 1];
%nmat=readmidi('escalasolmenorblancas.mid');
%nmat=readmidi('escaladomayor2.mid');

function Tc=centradodetonalidad(nmat);


%..Se extraen los vectores de la matriz de notas
P = pitch(nmat)';
R = ritmo(nmat) ;

%..número de figuras rítmicas
nr = length(R);
 N = length(P);
 %..la duración más corta de R.
q = min(R);

%.......numero de veces que está q dentro de R..........
nq = 0;     
for i=1:nr
    if R(1,i)==q
        nq=nq+1;
    end
end
%.......................................................

%..número de veces que la tonica o la dominante se ejecuta con el valor de q.
%tonalidad = kkkey(m1); %..algoritmo de Krumhansl-Kessler para hallar la tonalidad
%max(plotdist(pcdist1(m1))); histograma para las tonalidades más probables
%[indices,barra]=hist(pitch(nmat)); %..hallar el valor máximo de pitch
%tonica=max(barra);

tonalidad = kkkey(nmat); 
tonalidad = mod(tonalidad,12) - 1;

b=0; j=0;
while (b==0)
    for i=1:N
        if P(i)== (tonalidad + (12*j));
            tonica = P(i);  %..hallar el valor midi da tonica
            b=1;
        end
    end
    j=j+1;
end
dominante = tonica + 7;

%..normalización a la primera octava..
        P = mod(P,12);
   tonica = mod(tonica,12);
dominante = mod(dominante,12);
%.....................................

nqq=0;
for i=1:N
  if ((R(i)==q) && (P(i)==tonica))  || ((R(i)==q) && (P(i)==dominante))
      nqq = nqq + 1;
  end
end
%..........................................................................

%..hallar la densidad
Tc=nqq/nq;
%..número de veces que la tonica o la dominante se ejecutan con la figura de menor duración / cantidad de figuras con menor duración 
