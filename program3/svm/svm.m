function losses = svm()
%Vetor de medidas
[medidasR, classes] = medidas();

%SVM with HoldOut
CVSVMModel = fitcsvm(medidasR,classes,'Holdout',0.2,'ClassNames',[0,1],'Standardize',0);
CompactSVMModel = CVSVMModel.Trained{1}; % Extract the trained, compact classifier
testInds = test(CVSVMModel.Partition);   % Extract the test indices
XTest = medidasR(testInds,:);
YTest = classes(testInds,:);
svmHoldOut = loss(CompactSVMModel,XTest,YTest);

%SVM with LeaveOut
CVSVMModel2 = fitcsvm(medidasR,classes,'Leaveout','on','ClassNames',[0,1],'Standardize',0);
svmLeaveOut = CVSVMModel2.kfoldLoss;

%SVM with kFold
CVSVMModel3 = fitcsvm(medidasR,classes,'KFold',5,'ClassNames',[0,1],'Standardize',0);
svmkFold = CVSVMModel3.kfoldLoss;

%SVM polynomial
SVMModel = fitcsvm(medidasR,classes,'Standardize',1,'KernelFunction','polynomial');
cCVSVMModel = crossval(SVMModel);
svmPoly = kfoldLoss(cCVSVMModel);

%Optimize SVM Classifier
% rng default
% Mdl = fitcsvm(medidasR,classes,'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus'));
% crossMdl = Mdl.crossval;
% svmOptimized = kfoldLoss(crossMdl);

losses = [svmHoldOut, svmLeaveOut, svmkFold, svmPoly];

end