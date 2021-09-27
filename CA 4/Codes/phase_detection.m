function output = phase_detection(input)

output{10,1} = [];

for k = 1 : 10 
    output{k,1} = angle(input{k,1}); 
end

end

