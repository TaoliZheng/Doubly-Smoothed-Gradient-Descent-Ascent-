function [] = plot_figure_1(x_mat,y_mat,xy_range,iter_end,label,converge,plot_limit,exam)
%% plot figure
scatter(x_mat(1),y_mat(1),100,'black','filled','p');
hold on;
arrowPlot(x_mat(1:iter_end),y_mat(1:iter_end),'number',5,'color',[128,177,211]/256,'LineWidth',2,'scale',0.8);
hold on;
if converge ==1
    if exam==4
        scatter(0.078, 0.412,120,'filled','d','MarkerEdgeColor',[246,85,85]/256,...
    'MarkerFaceColor',[246,85,85]/256,...
              'LineWidth',1.5);
    else
    scatter(0,0,120,'filled','d','MarkerEdgeColor',[246,85,85]/256,...
    'MarkerFaceColor',[246,85,85]/256,...
              'LineWidth',1.5);
    end
else
    if plot_limit == 1
        plot(x_mat(50000:iter_end),y_mat(50000:iter_end),'color',[251,128,114]/256,'LineWidth',2,'DisplayName','Limit Cycles');
    end
end
hold on;
xlim([-xy_range-0.1 xy_range+0.1]);
ylim([-xy_range-0.1 xy_range+0.1]);

if exam==1
    xticks([-4 -2 0 2 4]);
    yticks([-4 -2 0 2 4]);
elseif exam == 2
    xticks([-2 -1 0 1 2]);
    yticks([-2 -1 0 1 2]);
elseif exam == 3
    xticks([-1 -0.5 0 0.5 1]);
    yticks([-1 -0.5 0 0.5 1]);
else
    xticks([-1.5 -0.5 0.5 1.5]);
    yticks([-1.5 -0.5 0.5 1.5]);
end

if label ==1
    fig = legend('Initialization','Trajectories','Location','northeast');
    set(fig,'FontName','Times New Roman','FontSize',17);
end
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