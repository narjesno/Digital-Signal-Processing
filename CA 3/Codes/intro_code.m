clc;
clear;
close all;
pink = [255 112 183]/255;
dark = [255 141 161]/255;
light = [251 174 210]/255;
yellow = [223 82 134]/255;
%%
%part 1

[c7Mic, Fs7] = audioread('Intro\c7Mic3Intro.wav');
figure 
spectrogram(c7Mic, length(c7Mic),0 ,Fs7 ,Fs7, 'yaxis' );
title("Spectrogram c7Mic")
colormap spring

[c8Mic, Fs8] = audioread('Intro\c8Mic3Intro.wav');
figure
spectrogram(c7Mic, length(c7Mic),0 ,Fs7 ,Fs7 , 'yaxis');
title("Spectrogram c8Mic")
colormap spring

%using window
spectrogram_window(c7Mic, Fs7);
title("Spectrogram c7Mic - Using Hann window")
spectrogram_window(c8Mic, Fs8);
title("Spectrogram c8Mic - Using Hann window")


%%
%part2
clc;
close all;

plot(c7Mic,'color', pink), title('Original c7Mic')
grid on
figure
plot(c8Mic,'color', pink), title('Original c8Mic')
grid on
figure

[data7_1, data7_2, data7_3, data7_4] = Filtering(7, c7Mic);
figure
[data8_1, data8_2, data8_3, data8_4] = Filtering(8, c8Mic);

%%

Data7_1 = decimate(data7_1, 4);
Data7_2 = decimate(data7_2, 4);
Data7_3 = decimate(data7_3, 4);
Data7_4 = decimate(data7_4, 4);


Data8_1 = decimate(data8_1, 4);
Data8_2 = decimate(data8_2, 4);
Data8_3 = decimate(data8_3, 4);
Data8_4 = decimate(data8_4, 4);

%%
%part3
clc;
close all;

Chunk7_1 = reshape([Data7_1;zeros(95,1)], 256, []);
Chunk7_2 = reshape([Data7_2;zeros(95,1)], 256, []);
Chunk7_3 = reshape([Data7_3;zeros(95,1)], 256, []);
Chunk7_4 = reshape([Data7_4;zeros(95,1)], 256, []);

Chunk8_1 = reshape([Data8_1;zeros(95,1)], 256, []);
Chunk8_2 = reshape([Data8_2;zeros(95,1)], 256, []);
Chunk8_3 = reshape([Data8_3;zeros(95,1)], 256, []);
Chunk8_4 = reshape([Data8_4;zeros(95,1)], 256, []);

%%
%part4

clc;
close all;

lag_index1 = zeros(141,1);
lag_index2 = zeros(141,1);
lag_index3 = zeros(141,1);
lag_index4 = zeros(141,1);


for i = 1:141
    [~,max_index] = max(abs(xcorr(Chunk7_1(1:256, i), Chunk8_1(1:256, i))));
    lag_index1(i) = max_index - 256; 
end

for i = 1:141
    [~,max_index] = max(abs(xcorr(Chunk7_2(1:256, i), Chunk8_2(1:256, i))));
    lag_index2(i) = max_index - 256; 
end

for i = 1:141
    [~,max_index] = max(abs(xcorr(Chunk7_3(1:256, i), Chunk8_3(1:256, i))));
    lag_index3(i) = max_index - 256; 
end

for i = 1:141
    [~,max_index] = max(abs(xcorr(Chunk7_4(1:256, i), Chunk8_4(1:256, i))));
    lag_index4(i) = max_index - 256; 
end


%%
%part5
close all
xlim = [-50 -50:3:50 50];

subplot(2,1,1) , histogram(lag_index1,xlim, 'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex1 for each Subchannel");
grid on

subplot(2,1,2) ,histogram(lag_index2,xlim, 'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex2 for each Subchannel");
grid on

figure 
subplot(2,1,1) ,histogram(lag_index3,xlim, 'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex3 for each Subchannel");
grid on

subplot(2,1,2) ,histogram(lag_index4,xlim, 'FaceColor', pink, 'EdgeColor' , pink);

title("Histogram of LagIndex4 for each Subchannel");
grid on

%%
clc;
close all;
subplot(2,1,1), h1 = histfit(lag_index1);
set(h1(1),'facecolor',light);
set(h1(1),'edgecolor',pink);
set(h1(2),'color',yellow);
display(fitdist(lag_index1, 'normal'));
title("Histogram of LagIndex1 for each Subchannel");
grid on

subplot(2,1,2), h2 = histfit(lag_index2);
set(h2(1),'facecolor',light);
set(h2(1),'edgecolor',pink);
set(h2(2),'color',yellow);
display(fitdist(lag_index2, 'normal'));
title("Histogram of LagIndex2 for each Subchannel");
grid on
figure
subplot(2,1,1), h3 = histfit(lag_index3);
set(h3(1),'facecolor',light);
set(h3(1),'edgecolor',pink);
set(h3(2),'color',yellow);
display(fitdist(lag_index3, 'normal'));
title("Histogram of LagIndex3 for each Subchannel");
grid on

subplot(2,1,2) , h4 = histfit(lag_index4);
set(h4(1),'facecolor',light);
set(h4(1),'edgecolor',pink);
set(h4(2),'color',yellow);
display(fitdist(lag_index4, 'normal'));
title("Histogram of LagIndex4 for each Subchannel");
grid on

%%
clc
close all
xlim = [-20:1:20];
[value1,~] = histcounts(lag_index1, xlim);
mu1 = -3;
sigma1 = calculate_sigma(value1, mu1);

[value2,~] = histcounts(lag_index2, xlim);
mu2 = 1;
sigma2 = calculate_sigma(value2, mu2);

[value3,~] = histcounts(lag_index3, xlim);
mu3 = 1;
sigma3 = calculate_sigma(value3, mu3);

[value4,~] = histcounts(lag_index4, xlim);
mu4 = -2;
sigma4 = calculate_sigma(value4, mu4);

