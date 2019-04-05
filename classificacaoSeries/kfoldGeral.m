function kfold = kfoldTest(score)

addpath('comuns/');
addpath('adaboost/');
addpath('n-supervisionado/');

perc = 0.3;
for i=1:10
   errAda(i) = kfoldAda(score(:,1:5), perc); 
   errClus(i) = kfoldClust(score(:,1:5), perc);
   errK(i) = kfoldKMeans(score(:,1:5), perc);
end
e1= 1-min(errAda)
e3 =1-min(errK)
e2 =1-min(errClus)

end



