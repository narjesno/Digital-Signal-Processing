clc;
clear;
close all;
pink = [255 112 183] / 255;
dark = [255 141 161] / 255;
light = [251 174 210] / 255;
yellow = [223 82 134] / 255;

%%
%part 1
close all;

[c7m19, Fs7] = audioread('main\c7m19.wav');
%sound(c7m19, Fs7);
%sound(c7m19,Fs7);
figure 
%spectrogram(c7m19, Fs7, 'yaxis');
spectrogram(c7m19, length(c7m19),0 ,Fs7 ,Fs7, 'yaxis');
title("Spectrogram c7m19")
colormap spring

[c8m19, Fs8] = audioread('main\c8m19.wav');
figure
%spectrogram(c8m19, Fs8, 'yaxis');
spectrogram(c7m19, length(c8m19),0 ,Fs7 ,Fs7, 'yaxis');
title("Spectrogram c8m19")
colormap spring

%using window
spectrogram_window(c7m19, Fs7);
title("Spectrogram c7m19 - Using Hann window")
spectrogram_window(c8m19, Fs8);
title("Spectrogram c8m19 - Using Hann window")


%%
%part2
clc
close all


plot(c7m19,'color', pink), title('Original c7m19')
grid on
figure
plot(c8m19,'color', pink), title('Original c8m19')
grid on
figure

[data7_1, data7_2, data7_3, data7_4] = Filtering(7, c7m19);
figure
[data8_1, data8_2, data8_3, data8_4] = Filtering(8, c8m19);

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

Chunk7_1 = reshape([Data7_1;zeros(124,1)], 256, []);
Chunk7_2 = reshape([Data7_2;zeros(124,1)], 256, []);
Chunk7_3 = reshape([Data7_3;zeros(124,1)], 256, []);
Chunk7_4 = reshape([Data7_4;zeros(124,1)], 256, []);

Chunk8_1 = reshape([Data8_1;zeros(124,1)], 256, []);
Chunk8_2 = reshape([Data8_2;zeros(124,1)], 256, []);
Chunk8_3 = reshape([Data8_3;zeros(124,1)], 256, []);
Chunk8_4 = reshape([Data8_4;zeros(124,1)], 256, []);


%%
%part4

clc;
close all;

lag_index1 = zeros(2813,1);
lag_index2 = zeros(2813,1);
lag_index3 = zeros(2813,1);
lag_index4 = zeros(2813,1);

for i = 1:2813
    [~,max_index] = max(abs(xcorr(Chunk7_1(1:256, i), Chunk8_1(1:256, i))));
    lag_index1(i) = max_index - 256; 
end

for i = 1:2813
    [~,max_index] = max(abs(xcorr(Chunk7_2(1:256, i), Chunk8_2(1:256, i))));
    lag_index2(i) = max_index - 256; 
end

for i = 1:2813
    [~,max_index] = max(abs(xcorr(Chunk7_3(1:256, i), Chunk8_3(1:256, i))));
    lag_index3(i) = max_index - 256; 
end

for i = 1:2813
    [~,max_index] = max(abs(xcorr(Chunk7_4(1:256, i), Chunk8_4(1:256, i))));
    lag_index4(i) = max_index - 256; 
end

%%
%part5
close all;
subplot(2,1,1), histogram(lag_index1,'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex1 for each Subchannel");
grid on 

subplot(2,1,2), histogram(lag_index2,'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex2 for each Subchannel");
grid on

figure 

subplot(2,1,1), histogram(lag_index3,  'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex3 for each Subchannel");
grid on

subplot(2,1,2), histogram(lag_index4, 'FaceColor', pink, 'EdgeColor' , pink);
title("Histogram of LagIndex4 for each Subchannel");
grid on

%%
%part7

mu1 = 0.4;
sigma1 = 0.6;

mu2 = -0.2;
sigma2 = 3.3;

mu3 = 0.1;
sigma3 = 5.6; 

mu4 =0.02;
sigma4 = .3;

%%

W_ch1 = lagIndex_coefficient(lag_index1, mu1, sigma1);
W_ch2 = lagIndex_coefficient(lag_index2, mu2, sigma2);
W_ch3 = lagIndex_coefficient(lag_index3, mu3, sigma3);
W_ch4 = lagIndex_coefficient(lag_index4, mu4, sigma4);

%%
%part8

Multiplied_Chunk7_1 = Multiplied_chunks(Chunk7_1, W_ch1);
Multiplied_Chunk7_2 = Multiplied_chunks(Chunk7_2, W_ch2);

Multiplied_Chunk7_3 = Multiplied_chunks(Chunk7_3, W_ch3);
Multiplied_Chunk7_4 = Multiplied_chunks(Chunk7_4, W_ch4);

Multiplied_Chunk8_1 = Multiplied_chunks(Chunk8_1, W_ch1);
Multiplied_Chunk8_2 = Multiplied_chunks(Chunk8_2, W_ch2);
Multiplied_Chunk8_3 = Multiplied_chunks(Chunk8_3, W_ch3);
Multiplied_Chunk8_4 = Multiplied_chunks(Chunk8_4, W_ch4);

%%
%part8 
close all;

Righthand_signal = remake_signal(Multiplied_Chunk7_1, Multiplied_Chunk7_2, Multiplied_Chunk7_3, Multiplied_Chunk7_4);
Righthand_signal_n = interp(Righthand_signal, 4)';

Lefthand_signal = remake_signal(Multiplied_Chunk8_1, Multiplied_Chunk8_2, Multiplied_Chunk8_3, Multiplied_Chunk8_4);
Lefthand_signal_n = interp(Lefthand_signal, 4)';

%sound(Righthand_signal_n, Fs7);
%sound(Lefthand_signal_n, Fs8);

audiowrite('Righthand_signal.wav', Righthand_signal_n, Fs7);
audiowrite('Lefthand_signal.wav', Lefthand_signal_n, Fs8);

%%
%part 9
close all


%[c3m19, Fs] = audioread('solo\c3m19.wav');
%sound(c3m19, Fs);


smoothedW_ch1 = smooth(W_ch1);
smoothedW_ch2 = smooth(W_ch2);
smoothedW_ch3 = smooth(W_ch3);
smoothedW_ch4 = smooth(W_ch4);
xlim = [0 0:0.05:1 1];
histogram(W_ch2, xlim, 'FaceColor', pink, 'EdgeColor' , pink);
hold on
histogram(smoothedW_ch2 ,xlim, 'FaceColor', light, 'EdgeColor' , light);
grid on;

Multiplied_sChunk7_1 = Multiplied_chunks(Chunk7_1, smoothedW_ch1);
Multiplied_sChunk7_2 = Multiplied_chunks(Chunk7_2, smoothedW_ch2);
Multiplied_sChunk7_3 = Multiplied_chunks(Chunk7_3, smoothedW_ch3);
Multiplied_sChunk7_4 = Multiplied_chunks(Chunk7_4, smoothedW_ch4);

Multiplied_sChunk8_1 = Multiplied_chunks(Chunk8_1, smoothedW_ch1);
Multiplied_sChunk8_2 = Multiplied_chunks(Chunk8_2, smoothedW_ch2);
Multiplied_sChunk8_3 = Multiplied_chunks(Chunk8_3, smoothedW_ch3);
Multiplied_sChunk8_4 = Multiplied_chunks(Chunk8_4, smoothedW_ch4);

%%
close all;
smoothed_Righthand_signal = remake_signal(Multiplied_sChunk7_1, Multiplied_sChunk7_2, Multiplied_sChunk7_3, Multiplied_sChunk7_4);
Righthand_signal_ns = interp(smoothed_Righthand_signal, 4)';

smoothed_Lefthand_signal = remake_signal(Multiplied_sChunk8_1, Multiplied_sChunk8_2, Multiplied_sChunk8_3, Multiplied_sChunk8_4);
Lefthand_signal_ns = interp(smoothed_Lefthand_signal, 4)';

%sound(Righthand_signal_ns, Fs7);

%sound(smoothed_Lefthand_signal, Fs8);

audiowrite('smoothed_Righthand_signal.wav', Righthand_signal_ns, Fs7);
audiowrite('smoothed_Lefthand_signal.wav', Lefthand_signal_ns, Fs8);

%%
