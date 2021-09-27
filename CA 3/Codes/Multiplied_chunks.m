function Multiplied_Chunk =  Multiplied_chunks(chunk, Wch)

Multiplied_Chunk = zeros(256,2812);

for i=1:2812
    Multiplied_Chunk(:,i) = (chunk(:,i)* Wch(i));
end
end

