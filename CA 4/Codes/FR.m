%%
%face recognition
clc
clear
close all

%%

Path = 'data\s0.8';
Directory = dir(fullfile(Path,'*.pgm'));
train = cell(size(Directory));
for k = 1:numel(Directory)
    train{k} = imread(fullfile(Path,Directory(k).name));
end
train = reshape(train, [],8);
%%
% for k =1:8
%     
%     subplot(1,8,k)
%     imshow(uint8(train{2,k}));
%     
% end

%%

Path = 'data\s0.2';
Directory = dir(fullfile(Path,'*.pgm'));
test = cell(size(Directory));
for k = 1:numel(Directory)
    test{k} = imread(fullfile(Path,Directory(k).name));
end

test = reshape(test, [], 2);
%%
%autoenc = trainAutoencoder(train, 100);
trained = load('autoenc.mat');
%%
reconstructed = predict(autoenc, test);
reconstructed = reshape(reconstructed, [], 8);

%%
close all
% for k =1:8
%     
%     subplot(2,8,k)
%     imshow(uint8(train{1,k}));
%     
%     subplot(2,8,k+8)
%     imshow(uint8(reconstructed{1,k}));
% end

%%

encoded_train = encode(autoenc, train);

encoded_test = encode(autoenc, test);

encoded_data = cat(2, encoded_train, encoded_test);

%%

for i = 1 : length(encoded_train)
    train_target_std = floor((i-1)/uint16(8)) + 1;
end

train_target = target_cal(length(encoded_train), train_target_std);



%%
net = trainSoftmaxLayer(encoded_train, train_target);
stacked = stack(autoenc, net);
%%


test_targets = eye(40);

%%
acc = 0;
total_sum = zeros(40);
min_index = 1;

for j = 1:80
    img = test{j};
    y = sim(stacked, double(img(:)));
end
 
for j = 1:80
    
    min_sum = sum(abs(y - test_targets(:,1)),2);
    min_index = min_index_cal(y, test_targets, min_sum);
    
    if ((floor((j-1) / 2) + 1) == min_index)
        acc = acc + 1;
    end
end

%%


perf = mse(stacked, test_targets, y);



