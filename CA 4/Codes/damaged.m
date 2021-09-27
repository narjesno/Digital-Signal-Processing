function output = damaged(input, snr)

output{10,1} = [];

for k = 1 : 10 
    output{k,1} = awgn(input{k,1},snr); 
end

end

