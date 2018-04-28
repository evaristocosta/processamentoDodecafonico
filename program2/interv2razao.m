function razao_interv = interv2razao(interv)

razao_interv = zeros(1,11);
for x=1:11
    i = interv(x);
    razao_interv(x) = 2^(i/12);
end
end

