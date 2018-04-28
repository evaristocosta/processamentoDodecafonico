function doo = make_all(banco,model)

[model,err,accuracy,taxasS,IndiceKappa,varKappa,cSaida,cTeste,CONF] = aprendizado(banco);
[ser,calc] = calcula_medidas();
doo = [result,ERR,CONF,KAPPA] = classify_2(calc,cTreinada,treinada,'NBC');

endfunction