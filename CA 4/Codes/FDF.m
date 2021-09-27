%%
%frequency domain filtering

clc;
clear;
close all;
Path = 'data\att-database-of-faces\s8\';
Directory = dir(fullfile(Path,'*.pgm'));
my_person1 = cell(size(Directory));
for k = 1:numel(Directory)
    my_person1{k} = imread(fullfile(Path,Directory(k).name));
end

% for k =1:10
%     subplot(1,10,k)
%     imshow(my_person1{k,1});
% end


for k = 1 : 10
    figure
    mesh(my_person1{k,1})
    colormap bone
end
%%
My_Person1{10,1} = [];

for k = 1 : 10 
    My_Person1{k,1} = fftshift(fft2(my_person1{k,1})); 
end

%%
close all

for k = 1 : 10
    figure
    mesh(abs(My_Person1{k,1}))
    colormap bone
end

%%
for k = 1 : 10
    figure
    mesh(angle(My_Person1{k,1}))
    colormap bone
end
%%
close all
My_Person1_phase = phase_detection(My_Person1);
My_Person1_abs = abs_detection(My_Person1);

snr = 1; %1 %0.5

damaged_abs =  damaged(My_Person1_abs, snr);
damaged_phase =  damaged(My_Person1_phase, snr);

%%
%part1

Built_Person1_damaged_phase = rebuild(damaged_phase, My_Person1_abs);
built_person1_damaged_phase{10,1} = [];

for k = 1 : 10 
    built_person1_damaged_phase{k,1} = ifft2(ifftshift(Built_Person1_damaged_phase{k,1})); 
end

for k =1:10
    subplot(1,10,k)
    imshow(uint8(built_person1_damaged_phase{k,1}));
end


%%
%part2

Built_Person_damaged_abs = rebuild(My_Person1_phase, damaged_abs);
built_person_switched_abs{10,1} = [];

for k = 1 : 10 
    built_person_switched_abs{k,1} = ifft2(ifftshift(Built_Person_damaged_abs{k,1})); 
end

for k =1:10
    subplot(1,10,k)
    imshow(uint8(built_person_switched_abs{k,1}));
end

%%
%

Path = 'data\att-database-of-faces\s10\';
Directory = dir(fullfile(Path,'*.pgm'));
my_person2 = cell(size(Directory));
for k = 1:numel(Directory)
    my_person2{k} = imread(fullfile(Path,Directory(k).name));
end
for k =1:10
    subplot(1,10,k)
    imshow(my_person2{k,1});
end


My_Person2{10,1} = [];

for k = 1 : 10 
    My_Person2{k,1} = fftshift(fft2(my_person2{k,1})); 
end

My_Person2_phase = phase_detection(My_Person2);
My_Person2_abs = abs_detection(My_Person2);

%%
%part3 

Built_Person12_switched_abs = rebuild(My_Person1_phase, My_Person2_abs);
built_person12_switched_abs{10,1} = [];

for k = 1 : 10 
    built_person12_switched_abs{k,1} = ifft2(ifftshift(Built_Person12_switched_abs{k,1})); 
end

for k =1:10
    subplot(1,10,k)
    imshow(uint8(built_person12_switched_abs{k,1}));
end
%%
%part4

Built_Person21_switched_abs = rebuild(My_Person2_phase, My_Person1_abs);
built_person21_switched_abs{10,1} = [];

for k = 1 : 10 
    built_person21_switched_abs{k,1} = ifft2(ifftshift(Built_Person21_switched_abs{k,1})); 
end

for k =1:10
    subplot(1,10,k)
    imshow(uint8(built_person21_switched_abs{k,1}));
end

%%

