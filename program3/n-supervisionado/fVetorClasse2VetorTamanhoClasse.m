
function TamanhosClasse = fVetorClasse2VetorTamanhoClasse(VetorClasse)

L = length(VetorClasse);
uC = max(unique(VetorClasse));

TamanhosClasse = zeros(1,uC);
for i=1:uC 
TamanhosClasse(1,i) = length(find(VetorClasse==i));
end;

