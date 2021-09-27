function desired_mat = remove_unwanted_data(sum)

parted_sum = [zeros(30, 1); sum(30: end - 30); zeros(29, 1)];

abs_sum = abs(parted_sum);

desired_mat = abs_sum;
end

