function sigma = calculate_sigma(value, mu)

area = 0;
for k = 1:40
    area = area + value(k);
end


j = (20 - mu);
right_area = 0;
left_area = 0;


for i = (21 + mu) : length(value)
  right_area  = right_area + value(i);
  left_area = left_area + value(j);
  if(right_area + left_area >= 0.997*area)
      break;
  end 
  j= j-1;
end

sigma = (i - (22+mu))/3;
end

