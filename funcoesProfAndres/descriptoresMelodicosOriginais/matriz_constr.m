function mtrx=matriz_constr(x,y,z,w)
mtr=vtrs(x,y,z,w);
%normaliza os valores
mtr=mod((mtr-mtr(1)+12),12)
inter=mtr;

for aux=1:12
    for aux2=1:12
        mtrx(aux,aux2)=mod(mtr(aux2)-inter(aux)+12,12);
    end
end
end
