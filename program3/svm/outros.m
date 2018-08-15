function losses = outros(medidasR)
[~, classes] = medidas('new');
rng(1);

%k-nearest neighbor
knnfit = fitcknn(medidasR,classes);
knn = resubLoss(knnfit);
%cross validation
cvknn = crossval(knnfit);
cvlknn = kfoldLoss(cvknn);

%Classification tree
treefitm = fitctree(medidasR,classes);
tree = treefitm.loss(medidasR,classes);
%Cross validated tree
CVtree = crossval(treefitm);
CVLtree = kfoldLoss(CVtree);

%Naive Bayes model
naivefit = fitcnb(medidasR,classes);
naive = naivefit.loss(medidasR,classes);
%Cross Validated naive bayes model
CVNaive = crossval(naivefit);
CVLNaive = kfoldLoss(CVNaive);

%Regression: for continuous-response values

%Linear classification models for two-class (binary) learning with high-dimensional, full or sparse predictor data.
% linearfit = fitclinear(medidasR,classes);
% linear = linearfit.loss(medidasR,classes);

%Efficiently trains linear regression models with high-dimensional, full or sparse predictor data. 
% regressfit = fitrlinear(medidasR,classes);
% linearRegression = regressfit.loss(medidasR,classes);

losses = [knn, cvlknn, tree, CVLtree, naive, CVLNaive];

end