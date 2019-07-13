function vtr_result = vtrs(x)%,y,z,w)
%Salva descr. de 3 vetores originais
intrvls_diss = [intervalos_diss(x)]%,intervalos_diss(y),intervalos_diss(z),intervalos_diss(w)]

[EC1,ECP1,ECN1,ECC1]=mldcStab(x);
%[EC2,ECP2,ECN2]=mldcStab(y);
%[EC3,ECP3,ECN3]=mldcStab(z);
%[EC4,ECP4,ECN4]=mldcStab(w);

%positivos=[ECP1,ECP2,ECP3,ECP4];
%negativos=[ECN1,ECN2,ECN3,ECN4];
%geral=[EC1,EC2,EC3,EC4];

%all=[geral,positivos,negativos]

%Calcula a m�dia
%avgID=average(intrvls_diss);
%avgEC=average(geral);
%avgECP=average(positivos);
%avgECN=average(negativos);

aux=0;
while aux==0   %gera novo vetor com valores semelhantes as medias
    vtr_seriemelodica = randperm(12)-1;

    ID_sm = intervalos_diss(vtr_seriemelodica)
    [EC_sm,ECP_sm,ECN_sm] = mldcStab(vtr_seriemelodica)
    
    if ~( ID_sm < ( intrvls_diss + ( intrvls_diss *0.4 )) && ID_sm > ( intrvls_diss - ( intrvls_diss *0.4 )))
        aux=0;
    elseif ~( EC_sm < ( EC1 + ( EC1*0.3 )) && EC_sm > ( EC1- ( EC1*0.3 )))
        aux=0;
    elseif ~( ECP_sm < ( ECP1 + ( ECP1*0.3 )) && ECP_sm > ( ECP1- ( ECP1*0.3 )))
        aux=0;
    elseif ~( ECN_sm < ( ECN1+ ( ECN1*0.3 )) && ECN_sm > ( ECN1- ( ECN1*0.3 )))
        aux=0;
    else
        aux=1;
    end
end
dados=[ID_sm,EC_sm,ECP_sm,ECN_sm]
vtr_result=vtr_seriemelodica;
end

function y=average(x)
y=sum(x)/length(x);
end