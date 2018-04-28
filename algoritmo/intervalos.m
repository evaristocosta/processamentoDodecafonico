function I=intervalos(P)
n=length(P);

for i=1:n-1
    I(i)=P(i+1)-P(i);
end
end
