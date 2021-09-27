function wch = lagIndex_coefficient(lag_index, mu, sigma)

wch =  exp((-(lag_index - mu).^2 / (2*sigma^2)));
 
end

