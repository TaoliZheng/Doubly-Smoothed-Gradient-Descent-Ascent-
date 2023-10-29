%% We compare our DSGDA with other algorithms on the four examples which are mentioned in Section 2
% exam: assign the example you are interested in.
% run_DSGDA, run_SGDA, run_DEG, run_CEG: assign the algorithm you are interested in.
% iter: number of iterations.
% plot_figure: choose whether you would like to plot the figures.

clear all
clc
plot_figure = 1;
exam = 1 ; 
run_DSGDA = 1; run_SGDA = 0; run_DEG = 0; run_CEG = 0;
iter = 100000;
%% Derivative and hessian for each example
syms x y
if exam ==1
    f(x,y) = (x^2-1)*(x^2-9)+10*x*y-(y^2-1)*(y^2-9);
    xy_range = 4;
elseif exam==2
    f(x,y) = (4*x^2-(y-3*x+x^3/20)^2-y^4/10)* exp(-(x^2+y^2)/100);
    xy_range = 2;
elseif exam ==3
    xy_range = 1;
else
    f(x,y) =x*(y-0.45)+x^2/4-x^4/2+x^6/6-y^2/4+y^4/2-y^6/6;
    xy_range = 1.5;
end
if exam ==3
    %% gradient 
    dfx = x*(-1+x^2+y^2)*(-9+16*x^2+16*y^2)-y;
    dfy = -y*(-1+x^2+y^2)*(-9+16*x^2+16*y^2)-x;
    if run_CEG ==1
        %% hessian 
        hxx = diff(dfx,x,1);
        hxy = diff(dfx,y,1);
        hyy = diff(dfy,y,1);
    end
else
    %% gradient
    dfx = diff(f(x,y),x,1);
    dfy = diff(f(x,y),y,1);
    if run_CEG ==1
        %% hessian 
        hxx = diff(f(x,y),x,2);
        hyy = diff(f(x,y),y,2);
        hxy = diff(diff(f(x,y),x,1),y,1);
    end
end
dfx = matlabFunction(dfx,'vars',{[x,y]});
dfy = matlabFunction(dfy,'vars',{[x,y]});
if run_CEG ==1
    %% Jocabian of G
    JF = [hxx hxy; -hxy -hyy];
    JF = matlabFunction(norm(JF)^{-1},'vars',{[x,y]});
end
%% initialization
if exam == 1
    x_init = [-4,-4,-4,-2,-2,0,0,2,2,4,4,4];
    y_init = [-2,0,2,-4,4,-4,4,-4,4,-2,0,2];
elseif exam ==2 || exam==3
    x_init = [-1,-1,-1,-0.5,-0.5,-0.5,0,0,0.5,0.5,0.5,1,1,1];
    y_init = [-1,0,1,-1,0,1,-1,1,-1,0,1,-1,0,1];
else
    x_init = [-1.2,-1.2,-1.2,-1.2,-0.4,-0.4,-0.4,-0.4,0.4,0.4,0.4,0.4,1.2,1.2,1.2,1.2];
    y_init = [1.2,-1.2,0.4,-0.4,1.2,-1.2,0.4,-0.4,1.2,-1.2,0.4,-0.4,1.2,-1.2,0.4,-0.4];
end

for i = 1:size(x_init,2)
% for i=1:2
x0 = x_init(i); y0 = y_init(i); 
z0 = x0; v0 = y0;
%% derivatives of smoothed potential function and parameters
if exam==1
    % parameters for DSGDA
    r1 = 5; r2 = 22;
    c = 1/500; alpha =1/50;
    beta = 1/5000; mu = 1/5000;
    % parameters for SGDA
    r1_sgda = 22;
    c_sgda = 1/50; alpha_sgda =1/200;
    beta_sgda = 1/10000;
    % parameters for CEG+
    lam = 0.2;
    % parameters for DEG
    lambda = 0.5;
    s = 1/364;
elseif exam==2
    % parameters for DSGDA
    r1 = 15; r2 = 1;
    c = 1/40; alpha =1/5;
    beta = 1/4; mu = 1/10;
    % parameters for SGDA
    r1_sgda = 1;
    c_sgda = 1/50; alpha_sgda =1/4;
    beta_sgda = 1/2;
    % parameter for CEG
    lam = 0.5;
    % parameters for DEG
    lambda = 0.5;
    s = 1/50;
elseif exam ==3
    % parameters for DSGDA
    r1 = 5; r2 = 1;
    c = 1/50; alpha =1/50;
    beta = 1/150; mu = 1/100;
    % parameters for SGDA
    r1_sgda = 5;
    c_sgda = 1/50; alpha_sgda =1/50;
    beta_sgda = 1/200;
    % parameters for CEG+
    lam = 0.3;
    % parameters for DEG
    lambda = 0.5;
    s = 1/400;
else
  % parameters for DSGDA
    r1 = 1; r2 = 1;
    c = 1/20; alpha =1/20;
    beta = 1/50; mu = 1/10;
    % parameters for SGDA
    r1_sgda = 1;
    c_sgda = 1/20; alpha_sgda =1/20;
    beta_sgda = 1/50;
    % parameters for CEG+
    lam = 0.3;
    % parameters for DEG
    lambda = 0.5;
    s = 1/50;
end
label = 0;
%% double smoothed GDA
if run_DSGDA == 1
    para = [r1,r2,c,alpha,beta,mu];
    [x_mat,y_mat,x,y,iter_end] = DSGDA(x0,y0,z0,v0,iter,xy_range,dfx,dfy,para);
    converge = 1;
end
%% smoothed GDA
if run_SGDA ==1
    para = [r1_sgda,0,c_sgda,alpha_sgda,beta_sgda,0];
    [x_mat,y_mat,x,y,iter_end] = DSGDA(x0,y0,z0,v0,iter,xy_range,dfx,dfy,para);
    if exam ==1
        converge = 0;
        limit_cycle =1;
    else
        converge = 1;
    end
end
%% CEG+
if run_CEG ==1
    [x_mat,y_mat,x,y,iter_end] = CEG(x0,y0,lam,iter,xy_range,dfx,dfy,JF);
    if exam ==4
        converge = 1;
    else
        converge = 0;
        limit_cycle =1;
    end
    if exam ==2 
        limit_cycle = 0;
    end        
end
%% Damped EG
if run_DEG ==1
    [x_mat,y_mat,x,y,iter_end] = DEG(x0,y0,s,lambda,iter,xy_range,dfx,dfy);
    converge = 0;
    if exam ==3
        label = 1;
    end
    limit_cycle = 1;
    if exam ==2 
        limit_cycle = 0;
    end   
end
%% check if it achieves a stationary point
fprintf("The derivative of f is %d and %d\n",dfx([x,y]),dfy([x,y]));
% fprintf("The algorithm starts at x=%d and y=%d\n",x_init(i),y_init(i));
% fprintf("The algorithm stops at x=%d and y=%d\n",x,y);
%% plot figures
plot_limit = 0;
if plot_figure==1
    if converge == 0 && limit_cycle ==1
        if i == size(x_init,2)
            plot_limit = 1;
        end
    end
    plot_figure_1(x_mat,y_mat,xy_range,iter_end,label,converge,plot_limit,exam);
end
end

