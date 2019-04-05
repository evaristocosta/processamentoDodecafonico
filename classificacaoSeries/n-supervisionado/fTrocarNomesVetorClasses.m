%..função para trocar os nomes de um vetor de classes segundo os nomes da
%tabela nomes
%..exemplo
% vetorClassesSaida = [3 3 3 2 2 2 1 1 1];
% nomes = [1 2; 2 3;3 1];
% V2 = fTrocarNomesVetorClasses(V1,nomes)

function V2 = fTrocarNomesVetorClasses(V1,nomes)

V2 = V1;
nC = max(V1); %..número de classes primeira classe =1
for i=1:nC
       I = find(V1==nomes(i,2));
   V2(I) = nomes(i,1);
end
