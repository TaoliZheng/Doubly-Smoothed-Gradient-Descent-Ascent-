%% We show the robustness of our parameters here.
% exam: assign the example you are interested in.
% iter: number of iterations.

clear all
clc
exam = 3; 
iter = 10000000;

%% Derivative for each example
syms x y
if exam==1
    f(x,y) = 2*x^2 - y^2 + 4*x*y + 4*y^3/3-y^4/4;
    xy_range =1;
elseif exam ==2 
    f(x,y) = x^2 + 3*sin(x)^2*sin(y)^2 - 4*y^2 - 10*sin(y)^2;
    xy_range =1;
else
    a = 11;
    f(x,y) = (x^2-1)*(x^2-9)+a*x*y-(y^2-1)*(y^2-9);
    xy_range =4;
end

%% gradient
dfx = diff(f(x,y),x,1);
dfy = diff(f(x,y),y,1);
dfx = matlabFunction(dfx,'vars',{[x,y]});
dfy = matlabFunction(dfy,'vars',{[x,y]});

%% initialization
x0 = -1; y0 = -1; 
z0 = x0; v0 = y0;

%% parameters for dsgda
paramat_dsgda = zeros(3,6,3);
paramat_dsgda(:,:,1) = [0.5 0.5 1/4 1/6 4/5 4/5; 0 0 0.01 0.01 0.01 0.01; 7.11 17.47 0.34 0.31 1 1];
paramat_dsgda(:,:,2) = [1/8 1/8 0.5 1/25 7/8 6/7; 0 0 0.01 0.01 0.01 0; 8.99 87.99 0.97 0.07 1 1];
paramat_dsgda(:,:,3) = [9 22 1/160 1/20 1/180 1/200; 5.968 21.550 0.003 0.040 0.001 0.001;13.605 26.189 0.008 0.062 0.014 0.09];

%% parameters for sgda
paramat_sgda = zeros(3,6,3);
paramat_sgda(:,:,1) = [1 0 1/4 1/10 2/3 0 ;0 0  0.01 0.01 0.01 0;6.22 0  0.37 0.30 1 0];
paramat_sgda(:,:,2) = [0.1 0 1/2 1/25 7/8 0; 0 0 0.01 0.01 0.01 0; 8.99 0 0.98 0.07 1 0];
paramat_sgda(:,:,3) = [20.4 0 1/30 1/1464 1/489930 0; 20.390 0  0.034 1/1510 1/526979 0; 20.4 0 0.067 1/1464 1/489930 0];

%% Compare of Doubly smoothed GDA and smoothed GDA
para_dsgda = paramat_dsgda(1,:,exam);
[x_mat,y_mat,~,~,iter_end] = DSGDA(x0,y0,z0,v0,iter,xy_range,dfx,dfy,para_dsgda);
% curve for optimal DSGDA
figure();
plot_figure_2(x_mat,y_mat,iter_end);

para_sgda =paramat_sgda(1,:,exam);
[x_mat,y_mat,~,~,iter_end] = DSGDA(x0,y0,z0,v0,iter,xy_range,dfx,dfy,para_sgda);
% curve for optimal SGDA
plot_figure_2(x_mat,y_mat,iter_end);
if exam ==3
legend('DSGDA','SGDA' );
set(gca,'FontSize',17);
set(gca, 'FontName','Times New Roman');
end
hold off;

%% Compare the range of parameters
paramat_dsgda(:,2,:)=[];
paramat_dsgda(:,end,:)=[];
paramat_sgda(:,2,:)=[];
paramat_sgda(:,end,:)=[];
x = [0 2.5 5 7.5;1 3.5 6 8.5; 1 3.5 6 8.5;0 2.5 5 7.5]; 
x1 = [1 3.5 6 8.5; 2 4.5 7 9.5;2 4.5 7 9.5;1 3.5 6 8.5]; 
y=[repmat(paramat_dsgda(2,:,exam),2,1);repmat(paramat_dsgda(3,:,exam),2,1)];
y1=[repmat(paramat_sgda(2,:,exam),2,1);repmat(paramat_sgda(3,:,exam),2,1)];
colorbox = [[250,127,111];[190,184,220]]/256;
figure()
patch(x,y,colorbox(1,:));
hold on;
patch(x1,y1,colorbox(2,:));
if exam ==3
    set(gca, 'YScale', 'log');
else 
     set(gca, 'YScale', 'linear');
end
ylabel("Range of parameters");
xlabel("Parameters");
if exam ==3
    legend('DSGDA','SGDA'); 
end
xticks([1 3.5 6 8.5]);
xticklabels({'r_1','c','\alpha','\beta'});
set(gca, 'GridAlpha',0.2);
set(gca, 'MinorGridAlpha',0.2);
set(gca,'linewidth',2);
set(gca,'FontSize',17);
set(gca, 'FontName','Times New Roman');
set(gcf,'color','w');
ax = gca;
axes.SortMethod='ChildOrder';