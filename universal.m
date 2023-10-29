%% We test the universality of DSGDA on the following example:
% \min_{-1<=x<=1} \max_{-1<=y<=1} f(x,y) = x^2 + 3*sin(x)^2*sin(y)^2 - 4*y^2 - 10*sin(y)^2;
clear all
clc
iter = 10000000;

%% Derivative for each example
syms x y
f(x,y) = x^2 + 3*sin(x)^2*sin(y)^2 - 4*y^2 - 10*sin(y)^2;
xy_range =1;

%% gradient
dfx = diff(f(x,y),x,1);
dfy = diff(f(x,y),y,1);
dfx = matlabFunction(dfx,'vars',{[x,y]});
dfy = matlabFunction(dfy,'vars',{[x,y]});

%% initialization
x0 = -1; y0 = -1; 
z0 = x0; v0 = y0;

%% Compare of Doubly smoothed GDA and smoothed GDA
para_dsgda = [  0.1250    0.1250    0.040    0.0400    0.8    0.8];
[x_mat,y_mat,x,y,iter_end] = DSGDA(x0,y0,z0,v0,iter,xy_range,dfx,dfy,para_dsgda);
%% check it achieves a stationary point
fprintf("The derivative of f is %d and %d\n",dfx([x,y]),dfy([x,y]));
%% curve for DSGDA
figure();
plot_figure_3 (x_mat,y_mat,xy_range,iter_end);