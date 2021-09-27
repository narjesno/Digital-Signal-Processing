function min_index = min_index_cal(y, test_targets, min_sum )

  for i = 1:40
        if sum(abs(y - test_targets(:, i))) < min_sum
            min_sum = sum(abs(y - test_targets(:, i)));
            min_index  = i ;
        else
           min_index = 1; 
        end
       
   end
    
end

