function output = rebuild(phase, abs)

output{10,1} = [];

for k = 1 : 10 
    output{k,1} = abs{k,1} .* exp(1i*(phase{k,1})); 
end

end
