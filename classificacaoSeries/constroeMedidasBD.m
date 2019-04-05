function user = constroeMedidasBD(salva)

addpath('medidas/');

n = 1;

descritivos = cell(118,10);
geral = cell(118,7);
estatisticos = cell(118,15);

%Abre dado do banco 
serie_all = abreBD();

while (n<119)    
    serie_mat=serie_all{n,2};
    serie_num=str2num(serie_mat);

    intr = diff(serie_num);
    %DESCRITIVOS
    %Intervalos dissonantes
    intrv_diss = intervalosdisonantes(intr);
    %Perfil melódico
    [dca,dcd] = direcciondecontorno(serie_num);
    %Estabilidade de contorno
    [EC,ECP,ECN] = estabilidaddelcontorno(serie_num);
    %Movimentos por passo
    Mpp = movimientosporpaso(intr);
    %Leap Return
    LR = saltosderetorno(intr);

    descritivos(n,1:10)={n,serie_mat,intrv_diss,EC,ECP,ECN,Mpp,dca,dcd,LR};
    
    %GERAIS E ESTATÍSTICOS
    [M, m, diff_interv, MN, mN, diffFL, gerais, normais, m_pond, dsv_p_pond] = geraisNormais(serie_num);
    geral(n,1:7)={n,serie_mat,M,m,diff_interv,MN,diffFL};
    
    media = gerais(1);
    desvio = gerais(2);
    moda = gerais(3);
    freq = gerais(4);
    outro = gerais(5);
    assm = gerais(6);
    
    mediaN = normais(1);
    desvioN = normais(2);
    modaN = normais(3);
    freqN = normais(4);
    outroN = normais(5);
    assmN = normais(6);
    
    estatisticos(n,1:16)={n,serie_mat,media,desvio,moda,freq,outro,assm,mediaN,desvioN,modaN,freqN,outroN,assmN,m_pond,dsv_p_pond};
    
    n=n+1;
end

if salva == 1
    %Salva no banco
    conn = database('dodecaf', 'root', '746136', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);
    
    %Tabela dos descritivos
    colname_desc = {'num','serie','id','ec','ecp','ecn','mpp','dca','dcd','lr'};
    table_desc = 'descritivos';
    datainsert(conn,table_desc,colname_desc,descritivos);
    
    %Tabela dos gerais
    colname_ger = {'num','serie','intrv_maior','intrv_menor','diff_intrv','intrv_maiorN','diffFL'};
    table_ger = 'gerais';
    datainsert(conn,table_ger,colname_ger,geral);
    
    %Tabela dos estatisticos
    colname_est = {'num','serie','m_artm','dsv_p','moda','frq_moda','mais_moda','assmtr','m_artmN','dsv_pN','modaN','frq_modaN','mais_modaN','assmtrN','m_ponderada', 'desv_p_ponderado'};
    table_est = 'estatisticos';
    datainsert(conn,table_est,colname_est,estatisticos);

    close(conn);
end

user = [descritivos, geral, estatisticos];
end




