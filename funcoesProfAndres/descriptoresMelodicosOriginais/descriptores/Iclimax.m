function clmx = Iclimax(x)
n = length(x);
c = max(x);
nc = 0;
for i=1:n
    if x(i) == c
        nc = nc+1;
    end
    
end

clmx=1/nc;