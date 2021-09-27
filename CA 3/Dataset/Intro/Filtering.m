function [data_1, data_2, data_3, data_4] = Filtering(no , cMic, Fs)

pink = [255 112 183]/255;


%[b1,a1] = ellip(10, 0.1,45, 0.25);
data_1 =lowpass(cMic); % Lowpass filter


[b2,a2] = iirshift(b1, a1, 0.25, 0.5);
data_2 = filtfilt(b2, a2, cMic); % band pass filter

[b3,a3] = iirshift(b1, a1, 0.25, 0.75);
data_3 = filtfilt(b3, a3, cMic); % Bandpass filter

Fnorm4 = 18/Fsnorm; 
[b4,a4] = iirlp2hp(b1, a1, 0.25, 0.5);
data_4 = filtfilt(b4, a4, cMic); % Highpass filter

%plotting
subplot(2,1,1), plot(data_1,'color', pink), title("c"+ no +" 1st Subchannel")
grid on
subplot(2,1,2), plot(data_2,'color', pink), title("c"+no+" 2nd Subchannel")
grid on

figure
subplot(2,1,1), plot(data_3,'color', pink), title("c"+no+" 3rd Subchannel")
grid on
subplot(2,1,2), plot(data_4,'color', pink), title("c"+no+" 4th Subchannel")
grid on

end

