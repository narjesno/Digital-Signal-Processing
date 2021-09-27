function [location, max_peak, removed_max] = find_position(desired_mat)

for i = 1 : length(desired_mat)
    if(desired_mat(i) == max(desired_mat))
        max_peak = max(desired_mat);
        desired_mat(i) = 0 ;
        location = i;
        break
    end
end

removed_max = desired_mat;
end

