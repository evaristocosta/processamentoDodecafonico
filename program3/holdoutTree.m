function erroArv = holdoutTree(score)
[~,classes]=medidas('new');
for i=1:10
    %Classification tree
    treefitm = fitctree(score(:,1:5),classes);
    %Cross validated tree
    CVtree = crossval(treefitm,'Holdout',0.3);
    erroArv(i) = 1-kfoldLoss(CVtree);
end
max(erroArv)
end