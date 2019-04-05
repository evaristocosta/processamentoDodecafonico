%..função que calcula a medida Google PageRank
%..exemplo
% i = [ 2 6 3 4 4 5 6 1 1];
% j = [ 1 1 2 2 3 3 3 4 6];
% n = 6;
% G = sparse(i,j,1,n,n);
% [x,A] = fPageRank(G)

function [x,A] = fPageRank(G)

n = length(G);
p = 0.85; %..Let p be the probability that the random walk follows a link.

c = sum(G,1);
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
e = ones(n,1);
I = speye(n,n);

x = (I - p*G*D)\e;
x = x/sum(x);

delta = (1-p)/n;
A = p*G*D + delta;