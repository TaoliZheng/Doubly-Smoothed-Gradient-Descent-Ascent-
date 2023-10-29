function [x_mat,y_mat,x,y,iter_end] = CEG(x,y, lam,iter,xy_range,dfx,dfy,g)
%% CEG+: 
% Escaping limit cycles: Global convergence for constrained nonconvex-nonconcave minimax problems
x_mat = zeros(1,iter);
y_mat = zeros(1,iter);
for k =1:iter
    x_mat(k) = x;
    y_mat(k) = y;
    % update
    % Lipschitz constant backtracking
    tau = 0.5; v= 0.99;
    gamma = v * g([x_mat(k)+0.1,y_mat(k)+0.1]);
    F = [dfx([x,y]);-dfy([x,y])];
    z = [x;y];
    H = z - gamma * F;
    x_temp = proj(H(1) ,xy_range);
    y_temp = proj(H(2) ,xy_range);
    F_temp= [dfx([x_temp, y_temp]); -dfy([x_temp, y_temp])];
    z_temp =[x_temp; y_temp];
    while gamma * norm(F_temp-F) >= v * norm(z-z_temp)
        gamma = gamma * tau;
        x_temp = proj(x - gamma * F(1),xy_range);
        y_temp = proj(y - gamma * F(2),xy_range);
        F_temp= [dfx([x_temp, y_temp]); -dfy([x_temp, y_temp])];
        z_temp =[x_temp; y_temp];
    end
    H_temp = z_temp - gamma * F_temp;
    H = z -  gamma * F;
    delta = -gamma/2 *0.99;
    alpha = delta/gamma + (z_temp-z)'*(H_temp -H)/norm(H_temp-H)^2;
    z = z + lam * alpha * (H_temp - H);
    x = z(1); 
    y = z(2);
    if abs(x-x_mat(k))<1e-6 && abs(y-y_mat(k))<1e-6
        iter_end = k;
        fprintf("It stops at iter=%f\n",k);
        break; 
    else
        iter_end = iter;
    end
end
end
