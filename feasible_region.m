%% Plot the feasible region for parameters selection
clear all
clc
% Define the parameters
mu = 1/5000  ;
beta = 1/5000 ;
kappa = 2 * beta;
% Suppose r = r1 = r2 = t2*L; c = alpha = 1/(t1*r); 
% Create a grid of t1 and t2 values
t1_values = linspace(1, 100, 500);
t2_values = linspace(1, 100, 500);
[T1, T2] = meshgrid(t1_values, t2_values);
% Compute the given expressions
c = 1 ./ (T1 .* T2);
sigma_1 = T2 ./ (T2 - 1);
sigma_2 = T2 ./ (T2 - 1);
sigma_5 = T2 ./ (T2 - 1);
sigma_3 = sigma_1.^2+1;
sigma_6 = T2 .* (2 + T1) ./ (T2 - 1);
sigma_8 = (sigma_1 + 1 + T2 + T1 .* T2) ./ (T2 - 1);
L_d = (sigma_1 + 1) + T2 ;
s1 = 1 ./ c - (T2 + 1)/ 2 - 1; % Line 643
s2 = 1 ./ c -  sigma_6.^2 - L_d + (T2 - 1) / 2; % Line 643
s3 = T2 .* (1/beta - 1/2 - 2 * sigma_2 - 1/kappa); % Line 644
coeff = mu * (2 - mu) .* T2  + 6 * T2 * kappa .* sigma_1.^2; % Line 655
coeff_x = s1 - s2 .* c.^2 .* sigma_6.^2 - 2 * coeff .* c.^2 .* sigma_6.^2 ;
coeff_y = s2/2 - 2 * coeff .* (1 + sigma_8).^2;
coeff_z = s3 - coeff .* sigma_3.^2;
coeff_v = T2 .* (1/(2 * mu) - 1/4 - 6 * kappa * sigma_1.^2 .* sigma_5.^2);
% Compute pos_x, pos_y, pos_z, and pos_v
pos_x = coeff_x - T2 / 1000;
pos_y = coeff_y - T2 / 1000;
pos_z = coeff_z - T2 / (1000 * beta);
pos_v = coeff_v - T2 / (1000 * mu);
% Create a binary mask for feasible region
feasible_mask = pos_x > 0 & pos_y > 0 & pos_z > 0 & pos_v > 0;
% Plot the feasible region
figure;
map = [166  206  227
    178 223 138]/256; 
contourf(T1, T2, double(feasible_mask), [0, 1]);
colormap(map);
xlabel('$T_1$','FontName', 'Times New Roman',...
    'Interpreter', 'latex', 'FontSize', 17);
ylabel('$T_2$','FontName', 'Times New Roman',...
    'Interpreter', 'latex', 'FontSize', 17);
title('Feasible Region');
grid on;
xt = [10 60];
yt = [70 50];
text(xt,yt,{'Feasible', 'Infeasible'},'FontSize',15);