diffscores = validationScores(:,1) - max([validationScores(:,2),validationScores(:,5),validationScores(:,3),validationScores(:,6),validationScores(:,4)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),0);
plot(X,Y,'LineWidth',1);
AUC

hold on

diffscores = validationScores(:,2) - max([validationScores(:,1),validationScores(:,5),validationScores(:,3),validationScores(:,6),validationScores(:,4)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),1);
plot(X,Y,'LineWidth',1);
AUC

diffscores = validationScores(:,3) - max([validationScores(:,2),validationScores(:,5),validationScores(:,1),validationScores(:,6),validationScores(:,4)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),2);
plot(X,Y,'LineWidth',1);
AUC

diffscores = validationScores(:,4) - max([validationScores(:,2),validationScores(:,5),validationScores(:,3),validationScores(:,6),validationScores(:,1)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),3);
plot(X,Y,'LineWidth',1);
AUC

diffscores = validationScores(:,5) - max([validationScores(:,1),validationScores(:,2),validationScores(:,3),validationScores(:,6),validationScores(:,4)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),4);
plot(X,Y,'LineWidth',1);
AUC

diffscores = validationScores(:,6) - max([validationScores(:,1),validationScores(:,5),validationScores(:,3),validationScores(:,2),validationScores(:,4)]);
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(response,diffscores(:,1),5);
plot(X,Y,'LineWidth',1);
AUC

hold off

legend('Stravinsky', 'Webern', 'Schoenberg', 'Krenek', 'Guerra-Peixe', 'Santoro')