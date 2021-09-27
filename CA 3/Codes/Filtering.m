function [data_1, data_2, data_3, data_4] = Filtering(no , cMic)

pink = [255 112 183]/255;


data_1 = filter(Lowpass, cMic); % Lowpass filter

data_2 = filter(Bandpass1, cMic); % Bandpass filter

data_3 = filter(Bandpass2, cMic); % Bandpass filter

data_4 = filter(Highpass, cMic); % Highpass filter

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

