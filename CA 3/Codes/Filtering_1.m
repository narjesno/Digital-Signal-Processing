function [data_1, data_2, data_3, data_4] = Filtering_1(no , cMic, Fs)

pink = [255 112 183]/255;


%[b1,a1] = butter(10, Fnorm1, 'low');
data_1 = lowpass(cMic); % Lowpass filter


[b2,a2] = butter(10,Fnorm2);
data_2 = filtfilt(b2, a2, cMic); % band pass filter

Fnorm3 = [12 18]/Fsnorm; 
[b3,a3] = butter(10,Fnorm3);
data_3 = filtfilt(b3, a3, cMic); % Bandpass filter

Fnorm4 = 18/Fsnorm; 
[b4,a4] = butter(10,Fnorm4, 'high');
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

