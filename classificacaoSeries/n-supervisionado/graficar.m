function saida = graficar(Te,Z,Y,NumAmostras)

Nc = max(unique(Te));
 
leafOrder = optimalleaforder(Z,Y); %..ordem �tima � um vetor com os n�m. das amostras
NumFolhas = 114;

%if Nc>1    
    color = Z(end-Nc+2,3)-eps;
    [H,T,perm] = dendrogram(Z,NumFolhas, 'colorthreshold', color,'Reorder',leafOrder,'Orientation','rigth');
    set(H,'LineWidth',2)
     set(gca,'XTick',0:NumAmostras,'FontSize',10);
%         xticklabel_rotate([1:NumAmostras],90,'interpreter','none')
%else
%     [H,T,perm] = dendrogram(Z,'Reorder',leafOrder);
%      set(gca,'XTick',0:NumAmostras,'FontSize',10);
%      xticklabel_rotate([1:NumAmostras],90,'interpreter','none')
end