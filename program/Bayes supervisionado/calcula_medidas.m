function calc = calcula_medidas()
  
  serie=randperm(12)-1;
  ite=serie(1);
  num=0;
  
  while(ite<12)
    ite++;
    num++;
  endwhile
  
  serie_f=mod((serie+num),11);

  intr=diff(serie_f);
  intrv_diss=intervalosdisonantes(intr);
  [dca,dcd]=direcciondecontorno(serie_f);
  [EC,ECP,ECN]=estabilidaddelcontorno(serie_f);
  Mpp = movimientosporpaso(intr);


    calc=[serie_f,intrv_diss,EC,ECP,ECN,Mpp,dca,dcd];
    
endfunction