function [M, m, diff_interv, MN, mN, diffFL, gerais, normais, m_pond] = geralzao(s1)
%Vetor de intervalos
s1I = diff(s1);

%Vetor de intervalos normais
s1IN = abs(s1I);

%Maior e menor intervalo geral
[M, m] = intervalomayormenor(s1I);
%Maior e menor intervalo normal
[MN, mN] = intervalomayormenor(s1IN);
%Diferença entre maior e menor intervalo gerais
diff_interv = M - m;
%Intervalo entre primeira e última nota
diffFL = s1(12) - s1(1);

% %Construção dos histogramas
% figure(1)
% histogram(s1I)
% figure(2)
% histogram(s1IN)

%Médias 
m_artm = mean(s1I);
m_artmN = mean(s1IN);
%Desvios padrão
dsv_p = std(s1I);
dsv_pN = std(s1IN);
%Média ponderada
s1IR = interv2razao(s1IN);
m_pond = sum(s1IN.*s1IR)/sum(s1IR);
%Modas, frequência e modas repetidas
[moda, frq, othr] = mode(s1I);
othr_rp = cell2mat(othr);
othr_rep = length(othr_rp);
% if othr_rep > 1
%     othr_rep = 1;
% else
%     othr_rep = 0;
% end
[modaN, frqN, othrN] = mode(s1IN);
othr_rpN = cell2mat(othrN);
othr_repN = length(othr_rpN);
% if othr_repN > 1
%     othr_repN = 1;
% else
%     othr_repN = 0;
% end

%Assimetria do histograma
skwns = skewness(s1I);
skwnsN = skewness(s1IN);

gerais = [m_artm, dsv_p, moda, frq, othr_rep, skwns];
normais = [m_artmN, dsv_pN, modaN, frqN, othr_repN, skwnsN];


end