function output = abs_detection(input)

output{10,1} = [];

for k = 1 : 10 
    output{k,1} = abs(input{k,1}); 
end

end

