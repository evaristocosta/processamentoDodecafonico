function info = aprendizados(opt)
%[erroSVM, erroOutros, supervisionadosErro, nSupervisionadosErro, adaBoostErro, erroNet, classestimate] 
addpath('svm/');
addpath('supervisionado/');
addpath('n-supervisionado/');
addpath('adaboost/');

switch opt
    case 1
        %Abordagem supervisionada
        fprintf('Abordagem supervisionada\n');
        fprintf('Resubstituição | HoldOut 0,7 | HoldOut 0,4 | kFold 10\n');
        supervisionadoResub = supervisionado(1);
        supervisionadoHold7 = supervisionado(2);
        supervisionadoHold4 = supervisionado(3);
        supervisionadoKFold = supervisionado(4);
        supervisionados = [supervisionadoResub,supervisionadoHold7,supervisionadoHold4,supervisionadoKFold];
        supervisionadosErro = 1 - supervisionados;
        info = supervisionadosErro;
    case 2
        %Abordagem não supervisionada
        fprintf('Abordagem não supervisionada\nCosseno e completo\n');
%         nSuperChebWght = HierarquicoNS(5,4);
%         nSuper1 = HierarquicoNS(10,3);
%         nSuper2 = HierarquicoNS(10,7);
%         nSuper3 = HierarquicoNS(10,4);
%         nSuper4 = HierarquicoNS(9,3);
%         nSuper5 = HierarquicoNS(9,7);
%         nSuper6 = HierarquicoNS(9,4);
%         nSuper7 = HierarquicoNS(8,4);
%         nSuper8 = HierarquicoNS(8,2);
%         nSuper9 = HierarquicoNS(8,1);
%         nSuper10 = HierarquicoNS(8,6);
%         nSuper11 = HierarquicoNS(7,2);
%         nSuper12 = HierarquicoNS(6,4);
        [nSuper13 ,~,~,cSaida,~]= HierarquicoNS(6,2);
        
        %nSupervisionados = [nSuperCorrAvg ,nSuperCosAvg ,nSuperChebWght ,nSuperCitySngl];
        nSupervisionados = nSuper13;
        nSupervisionadosErro = 1 - nSupervisionados;
        info.erro = nSupervisionadosErro;
        info.class = cSaida;
    case 3
        %Abordagem por máquinas de vetor suporte
        fprintf('Abordagem por máquinas de vetor suporte\n');
        fprintf('HoldOut 0,2 | LeaveOut | kFold 5 | Poly\n');
        erroSVM = svm();
        info = erroSVM;
    case 4
        %Outras abordagens
        fprintf('Abordagens gerais supervisionadas\n');
        fprintf('k-nearest neighbor & kfold | Classification tree & kfold | Naive Bayes & kfold\n');
        erroOutros = outros();
        info = erroOutros;
    case 5
        %Abordagem por Aprendizado Aglomerativo - adaptive boost
        fprintf('Abordagem por Aprendizado Aglomerativo - adaptive boost\n');
        [datafeatures, dataclass] = medidas('new');
        dataclass(1:19) = -1;
        [classestimate,model]=adaboost('train',datafeatures,dataclass,30);
        errorAda=zeros(1,length(model)); for i=1:length(model), errorAda(i)=model(i).error; end 
        adaboostError = errorAda(length(errorAda));
        %Validacao cruzada 
        adaErrokFold = kfoldAda(datafeatures, dataclass);
        adaBoostErro = [adaboostError,adaErrokFold];
        info.class = classestimate;
        info.erro = adaBoostErro;
    case 6
        %Redes neurais
        fprintf('Abordagem por Redes neurais\n');
        erroNet = neural();
        info = erroNet;
    otherwise
        disp('error')
end

end