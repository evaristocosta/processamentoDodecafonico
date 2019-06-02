function [ordemtotal, total, toptotal, totalcomtop, stravinsky, webern, schoenberg] = inicializadorBRACIS2019()

% ---------------------------------------
% --------- Obras de Stravinsky ---------
% Double Canon (1959)
serie = [0	11	3	2	1	8	6	9	10	7	5	4];
ordem = {'p00' 'p10' 'r00' 'r02' 'p00' 'p00' 'r00' 'r00' 'q08' 'q10' 'q08' 'q08' };
doubleCanon = medidasDeDerivadas(serie, ordem);

% Epitaphium (1959)
serie = [0	9	2	3	11	10	5	4	1	6	7	8];
ordem = {'p00' 'p00' 'q04' 'i00' 'r00' 'r00' 'i00' 'q04'};
epitaphium = medidasDeDerivadas(serie, ordem);

% Anthem (1962)
serie = [0	3	10	8	6	7	5	4	2	11	1	9];
ordem = {'r00' 'p00' 'q06' 'p00' 'q06' 'q06' 'i00' 'r00' 'r00' 'r00' 'p00' 'r00' 'i00' 'r00' 'q06' 'p00' 'r00' 'r00' 'q06' 'r00' 'i00' 'i00'};
anthem = medidasDeDerivadas(serie, ordem);

% Fanfare (1964)
serie = [0	11	1	3	4	2	5	7	6	8	10	9];
ordem = {'p00' 'p00' 'r00' 'q06' 'q00' 'r00' 'i00' 'i00' 'r00'};
fanfare = medidasDeDerivadas(serie, ordem);

% The Owl and the pussy cat (1966)
serie = [0	2	8	11	8	6	5	7	10	1	4	3];
ordem = {'p00' 'p00' 'i00' 'i00' 'q00' 'q00' 'i00' 'p00' 'i00' 'r00' 'p00' 'p00' 'i00' 'r00' 'q00' 'i06' 'i00' 'q00' 'i00' 'p00' 'p00' 'r00' 'q00' 'p00' 'i00' 'r00' 'p00' 'q00' 'q00'};
owl = medidasDeDerivadas(serie, ordem);

% Geral
ordemstravinsky = {'p00' 'p10' 'r00' 'r02' 'p00' 'p00' 'r00' 'r00' 'q08' 'q10' 'q08' 'q08'  'p00' 'p00' 'q04' 'i00' 'r00' 'r00' 'i00' 'q04' 'r00' 'p00' 'q06' 'p00' 'q06' 'q06' 'i00' 'r00' 'r00' 'r00' 'p00' 'r00' 'i00' 'r00' 'q06' 'p00' 'r00' 'r00' 'q06' 'r00' 'i00' 'i00' 'p00' 'p00' 'r00' 'q06' 'q00' 'r00' 'i00' 'i00' 'r00' 'p00' 'p00' 'i00' 'i00' 'q00' 'q00' 'i00' 'p00' 'i00' 'r00' 'p00' 'p00' 'i00' 'r00' 'q00' 'i06' 'i00' 'q00' 'i00' 'p00' 'p00' 'r00' 'q00' 'p00' 'i00' 'r00' 'p00' 'q00' 'q00'};
stravinsky = [doubleCanon, epitaphium, anthem, fanfare, owl];
% ---------------------------------------


% ---------------------------------------
% ----------- Obras de Webern -----------
serie = [0 8 7 11 10 9 3 1 4 2 6 5];

% Movimento 1
ordem = {'r08' 'p08' 'q08' 'i08' 'p08' 'r08' 'q08' 'i08' 'q01' 'i01' 'r09' 'r02' 'q06' 'i06' 'p07' 'r07' 'q11' 'i11' 'r00' 'p00' 'r00' 'p00' 'i00' 'q00' 'q05' 'i05' 'p05' 'r05' };
mov1 = medidasDeDerivadas(serie, ordem);

% Movimento 2
ordem = {'r00' 'q00' 'r07' 'q05' 'q10' 'r02' 'r05' 'q07'};
mov2 = medidasDeDerivadas(serie, ordem);

% Movimento 3
ordem = {'p00' 'i00' 'r00' 'p01' 'q00' 'q01' 'q07' 'q01' 'q06' 'q11' 'r06' 'r01' 'q06' 'r01' 'i09' 'q09' 'i08' 'p00' 'q11' 'p03' 'q02' 'r06' 'q05' 'p09' 'q08'  'p00' 'r00' 'i01' 'q01' 'r05' 'i05'};
mov3 = medidasDeDerivadas(serie, ordem);

% Geral
ordemwebern = {'r08' 'p08' 'q08' 'i08' 'p08' 'r08' 'q08' 'i08' 'q01' 'i01' 'r09' 'r02' 'q06' 'i06' 'p07' 'r07' 'q11' 'i11' 'r00' 'p00' 'r00' 'p00' 'i00' 'q00' 'q05' 'i05' 'p05' 'r05'  'r00' 'q00' 'r07' 'q05' 'q10' 'r02' 'r05' 'q07' 'p00' 'i00' 'r00' 'p01' 'q00' 'q01' 'q07' 'q01' 'q06' 'q11' 'r06' 'r01' 'q06' 'r01' 'i09' 'q09' 'i08' 'p00' 'q11' 'p03' 'q02' 'r06' 'q05' 'p09' 'q08'  'p00' 'r00' 'i01' 'q01' 'r05' 'i05'};
webern = [mov1, mov2, mov3];
% ---------------------------------------


% ---------------------------------------
% -------- Obras de Schoenberg ----------
% De Profundis
serie = [0	6	5	1	11	7	4	8	9	3	2	10];
ordem = {'p00' 'i03' 'p00' 'q03' 'r00' 'i03' 'r00' 'p00' 'q03' 'p00' 'q03' 'r00' 'r00' 'q03' 'r00' 'q03' 'q03' 'r00' 'p00' 'i03' 'p00' 'q03' 'i03' 'p00' 'i03' 'p00' 'i03' 'q03' 'p00' 'q03' 'p00' 'r00' 'p00' 'r00' 'q03' 'r00' 'p00' 'i03' 'p00' 'i03' 'i03' 'p00' 'i03' 'p00' 'q03' 'p00' 'r00' 'i03' 'q03' 'i03' 'q03' 'r00' 'i03' 'p00' 'i03'};
deprofundis = medidasDeDerivadas(serie, ordem);

% Op. 25
serie = [0	1	3	9	2	11	4	10	7	8	5	6];
ordem = {'p00' 'p06' 'i06' 'i06' 'r06' 'r06' 'p06' 'r00' 'r00' 'q00' 'q00' 'p00' 'p06' 'i00' 'p00' 'p06' 'i00' 'i00' 'q06' 'q06' 'i00' 'r00' 'p00' 'p00' 'i06' 'i00' 'q00' 'p06' 'p00' 'r00' 'i06' 'p00' 'r00' 'p06' 'i06' 'p00' 'p06' 'p00' 'p06' 'p00' 'r00' 'i06' 'q06' 'p06' 'i00' 'i06' 'p06' 'i00' 'q06' 'r00' 'p00' 'i00' 'i06' 'r00'};
op25 = medidasDeDerivadas(serie, ordem);

% Geral 
ordemschoenberg = {'p00' 'i03' 'p00' 'q03' 'r00' 'i03' 'r00' 'p00' 'q03' 'p00' 'q03' 'r00' 'r00' 'q03' 'r00' 'q03' 'q03' 'r00' 'p00' 'i03' 'p00' 'q03' 'i03' 'p00' 'i03' 'p00' 'i03' 'q03' 'p00' 'q03' 'p00' 'r00' 'p00' 'r00' 'q03' 'r00' 'p00' 'i03' 'p00' 'i03' 'i03' 'p00' 'i03' 'p00' 'q03' 'p00' 'r00' 'i03' 'q03' 'i03' 'q03' 'r00' 'i03' 'p00' 'i03' 'p00' 'p06' 'i06' 'i06' 'r06' 'r06' 'p06' 'r00' 'r00' 'q00' 'q00' 'p00' 'p06' 'i00' 'p00' 'p06' 'i00' 'i00' 'q06' 'q06' 'i00' 'r00' 'p00' 'p00' 'i06' 'i00' 'q00' 'p06' 'p00' 'r00' 'i06' 'p00' 'r00' 'p06' 'i06' 'p00' 'p06' 'p00' 'p06' 'p00' 'r00' 'i06' 'q06' 'p06' 'i00' 'i06' 'p06' 'i00' 'q06' 'r00' 'p00' 'i00' 'i06' 'r00'};
schoenberg = [deprofundis, op25];
% ---------------------------------------


% ======================================= BRACIS VAI ATÉ AQUI =======================================

% % ---------------------------------------
% % ---------- Obra de Krenek -------------
% serie = [0	5	6	9	8	4	10	7	11	3	1	2];
% ordemkrenek = {'p00' 'i07' 'p06' 'q11' 'p09' 'q03' 'p03' 'q09' 'p11' 'q05' 'r07' 'q01' 'i00' 'p07' 'i05' 'r11' 'i09' 'r03' 'i03' 'r09' 'i11' 'r05' 'q07' 'r01' 'p01' 'i06' 'p04' 'q10' 'p08' 'q02' 'p02'};
% krenek = medidasDeDerivadas(serie, ordemkrenek);
% % ---------------------------------------
% 
% 
% % ---------------------------------------
% % -------- Obras de Guerra-Peixe --------
% serie = [0	3	2	7	6	11	1	4	5	8	10	9];
% 
% % I Largo
% ordem = {'p00' 'p01' 'p01' 'p00' 'p01' 'p10' 'p00' 'p07' 'p01' 'p00' 'p04'};
% largo1 = medidasDeDerivadas(serie, ordem);
% 
% % II Alegro
% ordem = {'i00' 'i00' 'i00' 'i02' 'i02' 'i06' 'i04' 'i04' 'i09' 'i09' 'i09' 'i08' 'i08' 'i08' 'i06' 'i09' 'i09' 'i05' 'i05'};
% alegro = medidasDeDerivadas(serie, ordem);
% 
% % III Largo
% ordem = {'p03' 'p04' 'p03' 'p03' 'p00' 'p00' 'p00' 'p00'};
% largo2 = medidasDeDerivadas(serie, ordem);
% 
% % Geral
% ordemguerra = {'p00' 'p01' 'p01' 'p00' 'p01' 'p10' 'p00' 'p07' 'p01' 'p00' 'p04' 'i00' 'i00' 'i00' 'i02' 'i02' 'i06' 'i04' 'i04' 'i09' 'i09' 'i09' 'i08' 'i08' 'i08' 'i06' 'i09' 'i09' 'i05' 'i05' 'p03' 'p04' 'p03' 'p03' 'p00' 'p00' 'p00' 'p00' };
% guerra = [largo1, alegro, largo2];
% % ---------------------------------------
% 
% 
% % ---------------------------------------
% % --------- Obras de Santoro ------------
% % Quarteto n. 6 - Mov. II
% serie = [0	1	10	9	2	3	4	11	8	5	7	6];
% ordem = {'p02' 'p09' 'p04' 'p10' 'p11' 'p00' 'p01' 'p07' 'p06' 'p05' 'r05' 'r00' 'r05' 'p05' 'p10' };
% quarteto = medidasDeDerivadas(serie, ordem);
% 
% % A menina exausta
% serie = [0	5	10	7	3	11	1	8	2	9	6	4];
% ordem = {'p00' 'p09' 'p09' 'r09' 'p09' 'r09' 'p02' 'r04' 'r04' 'r11' 'r11'};
% menina = medidasDeDerivadas(serie, ordem);
% 
% % Asa ferida
% serie = [0	9	10	11	3	5	4	6	2	7	8	1];
% ordem = {'p00' 'p00' 'p00' 'p00' 'p00' 'p10' 'p11' 'p00' 'p00' 'p00' 'p00'};
% asa = medidasDeDerivadas(serie, ordem);
% 
% % Geral
% ordemsantoro = {'p02' 'p09' 'p04' 'p10' 'p11' 'p00' 'p01' 'p07' 'p06' 'p05' 'r05' 'r00' 'r05' 'p05' 'p10'  'p00' 'p09' 'p09' 'r09' 'p09' 'r09' 'p02' 'r04' 'r04' 'r11' 'r11' 'p00' 'p00' 'p00' 'p00' 'p00' 'p10' 'p11' 'p00' 'p00' 'p00' 'p00' };
% santoro = [quarteto, menina, asa];
% % ---------------------------------------


% =======================================
% =========== TODAS MEDIDAS =============
ordemtotal = [ordemstravinsky, ordemwebern, ordemschoenberg];
total = [stravinsky, webern, schoenberg];

% Classes
topstravinsky = zeros(1,length(stravinsky));
topwebern = ones(1,length(webern));
topschoenberg = (ones(1,length(schoenberg)))+1;
% topkrenek = (ones(1,length(krenek)))+2;
% topguerra = (ones(1,length(guerra)))+3;
% topsantoro = (ones(1,length(santoro)))+4;
toptotal = [topstravinsky, topwebern, topschoenberg];

% Para classificador: a primeira linha contém as classes
totalcomtop = [toptotal;total];
% =======================================

end