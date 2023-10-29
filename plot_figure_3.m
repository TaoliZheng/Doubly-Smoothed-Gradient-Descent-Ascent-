function [] = plot_figure_3 (x_mat,y_mat,xy_range,iter_end)
%% plot figure
scatter(x_mat(1),y_mat(1),100,'black','filled','p');
hold on;
arrowPlot(x_mat(1:iter_end),y_mat(1:iter_end),'number',5,'color',[128,177,211]/256,'LineWidth',2,'scale',0.8);
hold on;
scatter(0,0,120,'filled','d','MarkerEdgeColor',[246,85,85]/256,...
    'MarkerFaceColor',[246,85,85]/256,...
              'LineWidth',1.5);
hold on;
xlim([-xy_range-0.1 xy_range-0.5]);
ylim([-xy_range-0.1 xy_range-0.5]);
xticks([-1 -0.5 0 0.5 ]);
yticks([-1 -0.5 0 0.5 ]);
fig = legend('Initialization','Trajectories','Location','northeast');
set(fig,'FontName','Times New Roman','FontSize',17);
grid on
box on
set(gca, 'GridAlpha',0.2);
set(gca, 'MinorGridAlpha',0.2);
set(gca,'linewidth',2);
set(gca,'FontSize',17);
set(gca, 'FontName', 'AGaramondPro-Regular')
set(gcf,'color','w');
ax = gca;
axes.SortMethod='ChildOrder';
end