function normal = normalizaHistcounts(intervalos)

hist = histcounts(intervalos);

up = 11 - max(intervalos);
down = 11 + min(intervalos); 

consertaF = zeros(1,up);
consertaI = zeros(1,down);

hist = horzcat(consertaI,hist);
normal = horzcat(hist,consertaF);

end