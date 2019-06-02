function [IW, raio, diametro, eficiencia, ma, MKin, MKout, MKtot, MSin, MSout, MStot, r0] = MedidasDeRedes(M)

%..Medidas para redes direcionadas e com pessos
A = double(M>0); %..Matriz de adjacencia bin�ria (digrafo sem pesos )
n = length(M); %..n�mero de n�s

[D] = floydwarshall(M,n); %..matriz de distancias [DW,DB,DWB]
 
%.................Medidas relacionadas com a dist�ncia.....................
%..Indice de wiener: somat�ria de todos os caminhos m�nimos
IW = sum(sum(D(D~=Inf))); %..em m�dia � mais r�pido do que sum(sum(D));

%..Excentricidade
exc = max(D.*(D~=Inf),[],2);

%..R�dio
raio = min(exc(exc~=0));  % valor m�nimo da eccentricidade

%..Di�metro
diametro = max(exc); 

%..Efici�ncia global
            Dinv = 1./D;                           %..inverso das dist�ncia
 Dinv(1:n+1:end) = 0;                    %..diagonal a zeros porque 1/0=inf
      eficiencia = sum(Dinv(:))/(n*(n-1));  %..calcular a m�dia sem diagonal ppal. com diagonal seria N^2

%..M�dia harm�nica
ma = 1/eficiencia;


%...Medidas relacionadas com o grau
%....Grau de entrada, sa�da e total
  Kin = sum(A,1);    %..grau de entrada
 Kout = sum(A,2)';    %..grau de sa�da
 Ktot = Kin + Kout;  %..grau total
 MKin = sum(Kin)/n;        %..Grau m�dio de entrada = m�dia Grau de sa�da
MKout = sum(Kout)/n;       %..Grau m�dio de sa�da   = m�dia Grau de entrada
MKtot = sum(Ktot)/n ;      %..Grau m�dio total = n�o tem sentido
 
%.....For�a do grau
 Sin = sum(M,1);           %..for�a de sa�da
Sout = sum(M,2)';          %..for�a de entrada
Stot = Sin + Sout;         %..for�a total (in + out) 
MSout = sum(Sout)/n;       %..for�a m�dia de sa�da 
 MSin = sum(Sin)/n;        %..for�a m�dio de entrada
MStot = sum(Stot)/n;       %..for�a m�dia total 

%...Pearson
r0 = assortativity(M,1);

VetorMedidas = [IW, raio, diametro, eficiencia, ma, MKin, MKout, MKtot, MSin, MSout, MStot, r0];
end



