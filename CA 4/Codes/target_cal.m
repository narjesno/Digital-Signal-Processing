function train_target = target_cal(len, target_std)

    for i =1:len
         train_target(:,i) = ind2sub(1:40, 1:40 == target_std);
    end
    
end

