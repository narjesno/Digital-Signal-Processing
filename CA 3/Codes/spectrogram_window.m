function spectrogram_window(cMic, Fs)

window_len = 0.004;
overlap = 0.5;
nfft = (Fs *window_len)/overlap;
noverlap = nfft - (Fs *window_len);
window = sqrt(hann(nfft));
figure
spectrogram(cMic, window, noverlap, nfft, Fs, 'yaxis');
colormap spring

end

