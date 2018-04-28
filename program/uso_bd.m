function user = uso_bd()
  n=1;
%  matra=zeros(12,12);
%  y=0;

all_data=cell(108,9);
serie_all=abre_bd2();

while (n<109)
  %asd=n
    %Abre dado do banco 
     serie_mat=serie_all{n,2};
     serie_num=str2num(serie_mat);

    %Realiza os calculos
    intr=diff(serie_num);
    intrv_diss=intervalosdisonantes(intr);
    [dca,dcd]=direcciondecontorno(serie_num);
    [EC,ECP,ECN]=estabilidaddelcontorno(serie_num);
    Mpp = movimientosporpaso(intr);

    %elabora rede
%    y+=rede(serie_num,matra);
    all_data(n,1:9)={n,serie_mat,intrv_diss,EC,ECP,ECN,Mpp,dca,dcd};
    %Salva no banco
    %pq_exec_params (x, "insert into measures values ($1,$2,$3,$4,$5,$6,$7,$8,$9);",{n,serie_mat,intrv_diss,EC,ECP,ECN,Mpp,dca,dcd});
    n=n+1;
end

conn = database('dodecaf', 'evaristo', '746136', 'Vendor', 'POSTGRESQL', 'Server', 'localhost', 'PortNumber', 5432);
colname={'num','serie','id','ec','ecp','ecn','mpp','dca','dcd'};
table_n='measures';
datainsert(conn,table_n,colname,all_data);
close(conn);

user=all_data;
   
end