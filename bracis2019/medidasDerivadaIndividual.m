function dados = medidasDerivadaIndividual(serie)

%Vetor de intervalos
intr = diff(serie);
%Matriz de pesos da rede de intervalos 
WI = intervalo_matriz_total(intr);

%Vetor com soma das linhas
L = sum(WI(:,:));
%Vetor com soma das colunas
C = sum(WI(:,:)');


% -----------------------------------
% Medidas comuns de redes
[raio, media_harmonica, MKtot, MStot, r0, coef_clustering, coef_clustering_ponderado] = mseletas(WI);
% -----------------------------------

% -----------------------------------
%Maior e menor intervalo
[M, m] = intervaloMaiorMenor(L, C);
%Diferença entre maior e menor intervalo gerais
diff_interv = M - m;


%Médias e desvios
[media, m_ponderada, desv_p, desv_p_pond] = estatisticas(L, C);
%Moda e frequencia
[moda, frq] = modaFreq(L, C);

%Assimetria
assimetria = (media - moda)/desv_p;

%               1           2           3      4     5           6                   7              8  9     10 	     11      12       13            14       15   16       17           
dados(1:15) = {raio, media_harmonica, MKtot, MStot, r0, coef_clustering, coef_clustering_ponderado, M, m, diff_interv, media, desv_p,                            moda, frq, assimetria};
%dados(1:17) = {raio, media_harmonica, MKtot, MStot, r0, coef_clustering, coef_clustering_ponderado, M, m, diff_interv, media, desv_p, m_ponderada, desv_p_pond, moda, frq, assimetria};

end