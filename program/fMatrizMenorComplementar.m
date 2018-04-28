

function M1 = fMatrizMenorComplementar(M,i,j)

[fM,cM] = size(M);

if i<=fM && j<=cM
M1 = M;
M1(i,:) = [];
M1(:,j) = [];
else
    disp('erro');
    M1 = 0;
end