function [x_mat,y_mat,x,y,iter_end] = DEG(x,y,s,lam,iter,xy_range,dfx,dfy)
%% (Damped) EGM:
% On the linear convergence of extra-gradient methods for nonconvex-nonconcave minimax problems
x_mat = zeros(1,iter);
y_mat = zeros(1,iter);
for k=1:iter
    x_mat(k) = x;
    y_mat(k) = y;
    % update
    x_temp = proj(x - s * dfx([x,y]),xy_range);
    y_temp = proj(y + s * dfy([x,y]),xy_range);
    x = proj(x - lam * s * dfx([x_temp, y_temp]),xy_range);
    y = proj(y + lam * s * dfy([x_temp, y_temp]),xy_range);
    if abs(x-x_mat(k))<1e-6 && abs(y_mat(k)-y)< 1e-6
        iter_end = k;
        fprintf("It stops at iter=%f\n",k);
        break;
    else
        iter_end = iter;
    end
end
end