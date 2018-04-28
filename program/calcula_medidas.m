function [ser,calc] = calcula_medidas()
  
  %serie=randperm(12)-1;
  serie=[0,6,11,8,2,1,3,9,5,4,7,10];
  ite=serie(1);
  num=1;
  
  while(ite<11)
    ite++;
    num++;
  endwhile
  
  serie_f=mod((serie+num),12);
  ser=serie_f;
  
  intr=diff(serie_f);
  intrv_diss=intervalosdisonantes(intr);
  [dca,dcd]=direcciondecontorno(serie_f);
  [EC,ECP,ECN]=estabilidaddelcontorno(serie_f);
  Mpp = movimientosporpaso(intr);


    calc=[intrv_diss,EC,ECP,ECN,Mpp,dca,dcd];
    
endfunction