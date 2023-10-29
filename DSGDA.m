function [x_mat,y_mat,x,y,iter_end] = DSGDA(x,y,z,v,iter,xy_range,dfx,dfy,para)
%% Our algorithm
r1 = para(1); r2 = para(2);
c = para(3); alpha = para(4);
beta = para(5); mu = para(6);
%% double smoothed GDA
x_mat = zeros(1,iter);
y_mat = zeros(1,iter);
iter_end = 0;
for k =1:iter
 
    x_mat(k) = x;
    y_mat(k) = y;
    % update
     x = proj(x - c * (dfx([x,y])+r1*(x-z)),xy_range);
    y = proj(y + alpha * (dfy([x,y])-r2*(y-v)),xy_range);
    z = z + beta * (x - z);
    v = v + mu * (y - v);
    
    if mu ==0
         if abs(z-x)<1e-6 && abs(y-y_mat(k))<1e-6
             iter_end = k;
             fprintf("It stops at iter=%f\n",k);
             break;
         else
             iter_end = iter;
         end
    else
        if abs(z-x)<1e-6 && abs(v-y)< 1e-6
            iter_end = k;
            fprintf("It stops at iter=%f\n",k);
            break;
        else
            iter_end = iter;
        end
    end
end
end