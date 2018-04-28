function savebd = teste(x)
n=1;
serie_cell = pq_exec_params (x, "select serie from everything where num=$1;",{n}).data;

serie_mat=cell2mat(serie_cell);

serie_num=str2num(serie_mat);


intr_d=intervalos_diss(serie_num);
[EC,ECP,ECN,ECC]=mldcStab(serie_num);

savebd=pq_exec_params (x, "insert into measures values ($1,$2,$3,$4,$5,$6);",{n,serie_mat,intr_d,EC,ECP,ECN});
endfunction 

