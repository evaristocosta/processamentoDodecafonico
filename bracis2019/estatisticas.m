function [media, m_ponderada, desv_p, desv_p_pond] = estatisticas(L, C)
% --------------------- CÁLCULO DE MÉDIA ---------------------  %
% inicializa variaveis
numerador = 0;
denominador = 0;
num_p = 0;
den_p = 0;

% realiza soma
for i=1:length(L) % sempre 23
    % da media normal
    numerador = numerador + ((i-12)*max([L(i) C(i)]));
    denominador = denominador + (max([L(i) C(i)]));
    
    % da media ponderada
    si = 2^(abs(i-12)/12); %  Razãoo Intervalar da Escala Igualmente Temperada
    num_p = num_p + ((i-12)*max([L(i) C(i)])*si);
    den_p = den_p + (max([L(i) C(i)])*si);
end

%faz a media
media = numerador / denominador;
m_ponderada = num_p / den_p;
% --------------------- FIM DO CÁLCULO DE MÉDIA ---------------------  %


% --------------------- CÁLCULO DE DESVIO PADRÃO ---------------------  %
% reinicializa variaveis
numerador = 0;
denominador = 0;
num_p = 0;
den_p = 0;

%realiza soma
for i=1:length(L) % sempre 23
    % p/ desvio padrao
    numerador = numerador + ( ( ( (i-12) * max([L(i) C(i)]) ) -media )^2 );
    denominador = denominador + ( max([L(i) C(i)]) );
    
    % p/ desvio padrao ponderado
    si = 2^(abs(i-12)/12); %  Razãoo Intervalar da Escala Igualmente Temperada
    num_p = num_p + ( ( ( ( (i-12) * max([L(i) C(i)]) ) -m_ponderada )^2 ) * si );
    den_p = den_p + ( max([L(i) C(i)]) * si );
end

desv_p = sqrt(numerador / denominador);
desv_p_pond = sqrt(num_p / den_p);
% --------------------- FIM DO CÁLCULO DE DESVIO PADRÃO ---------------------  %

end