function plot_figure_2(x_mat,y_mat,iter_end)
%% plot figure
z_mat = sqrt(x_mat.^2+y_mat.^2);
loglog(z_mat(1:iter_end),'linewidth',2);
hold on;

xlabel('Iterations','FontName','Times New Roman', 'FontSize', 17);  
ylabel('$\|\mathbf{u}^\texttt{k}-\mathbf{u}^*\|$','FontName', 'Times New Roman',...
    'Interpreter', 'latex', 'FontSize', 17);
set(gca, 'GridAlpha',0.2);
set(gca, 'MinorGridAlpha',0.2);
set(gca,'linewidth',2);
set(gcf,'color','w');
ax = gca;
axes.SortMethod='ChildOrder';
end