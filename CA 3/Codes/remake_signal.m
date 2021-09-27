function signal = remake_signal(chunk1, chunk2, chunk3, chunk4)

signal1 = reshape(chunk1,[],1)';
signal2 = reshape(chunk2,[],1)';
signal3 = reshape(chunk3,[],1)';
signal4 = reshape(chunk4,[],1)';

signal = signal1 + signal2 + signal3 + signal4;
end

