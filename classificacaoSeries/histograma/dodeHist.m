function result = dodeHist(serie_esc)
serie = escolheSerie(serie_esc);

sI = diff(serie);
sIN = abs(sI);

if length(serie) == 12
    figure(1)
    histogram(sI)

    figure(2)
    histogram(sIN)
    
    result = 1;
else
    result = 0;
end
end