%..Función para contar las veces que un vector de notas contiene un
%intervalos especifico

function Nip=contarintervalo(P,intervalo)

I=intervalos(P);
ni=length(P);


Nip=0;
for i=1:ni
    if abs(I(1,i))==intervalo
        Nip=Nip+1;
    end
end