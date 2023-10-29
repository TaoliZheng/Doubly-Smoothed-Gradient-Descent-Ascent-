function z = proj(z,z_range)
%% Project the iterates to the constraint set
 if z>z_range
     z = z_range;
 elseif z<-z_range
     z = -z_range;
 end