Fd = 1000;
Fs_downsampled = 250;
td = 1/Fd;
ts_downsampled = 1/Fs_downsampled;
T = 1;
t = td:td:T;
f_m = 200;

xsig = cos(2*pi*f_m*t);
length_xsig = length(xsig);
Nfactor = ts_downsampled/td;
x_sig_downsampled = downsample(xsig,Nfactor);
xsig_sampled = upsample(x_sig_downsampled,Nfactor);

f_sig = (-(length_xsig-1)/2:(length_xsig-1)/2)*(Fd/length_xsig);
fre_xsig = fftshift(fft(xsig, length_xsig));
fre_xsig_downsampled = fftshift(fft(xsig_sampled, length_xsig));

figure
plot(t, xsig, 'b')
hold on
stem(t, xsig_sampled, 'r')
grid on
legend('Original Spectrum', 'Sampled Spectrum')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.2])
ylim([-1.5 1.5])

figure
stem(f_sig, abs(fre_xsig)/length_xsig, 'b')
hold on
stem(f_sig, abs(fre_xsig_downsampled)/length_xsig, 'r')
grid on
legend('Original Spectrum', 'Sampled Spectrum')
xlabel('Frequency (Hz)')
ylabel('Gain')
axis([-500 500 0 0.6])

f_cutoff = 70;
f_stop = 110;
lpFilt = designfilt('lowpassfir','PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate',Fd);
fvtool(lpFilt)
filtered_x_sig_downsampled = Nfactor.*filter(lpFilt,xsig_sampled);
fre_filtered_x_sig_downsampled = fftshift(fft(filtered_x_sig_downsampled,length_xsig));

figure
plot(t, xsig, 'b')
hold on
plot(t, filtered_x_sig_downsampled, 'r')
grid on
legend('Original Spectrum', 'Recovered Signal')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.2])
ylim([-1.5 1.5])

figure
stem(f_sig, abs(fre_xsig)/length_xsig, 'b')
hold on
stem(f_sig, abs(fre_filtered_x_sig_downsampled)/length_xsig, 'r')
grid on
legend('Original Spectrum', 'Recovered Spectrum')
xlabel('Frequency (Hz)')
ylabel('Gain')
axis([-500 500 0 0.6])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fd = 1000;
Fs_downsampled = 200;
td = 1/Fd;
ts_downsampled = 1/Fs_downsampled;
T = 1;
t = td:td:T;
f_m = 10;

xsig = square(2*pi*f_m*t);
length_xsig = length(xsig);
Nfactor = ts_downsampled/td;
x_sig_downsampled = downsample(xsig,Nfactor);
xsig_sampled = upsample(x_sig_downsampled,Nfactor);

f_sig = (-(length_xsig-1)/2:(length_xsig-1)/2)*(Fd/length_xsig);
fre_xsig = fftshift(fft(xsig, length_xsig));
fre_xsig_downsampled = fftshift(fft(xsig_sampled, length_xsig));

figure
plot(t, xsig, 'b')
hold on
stem(t, xsig_sampled, 'r')
grid on
legend('Original Spectrum', 'Sampled Spectrum')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.2])
ylim([-1.5 1.5])

figure
stem(f_sig, abs(fre_xsig)/length_xsig, 'b')
hold on
stem(f_sig, abs(fre_xsig_downsampled)/length_xsig, 'r')
grid on
legend('Original Spectrum', 'Sampled Spectrum')
xlabel('Frequency (Hz)')
ylabel('Gain')
axis([-500 500 0 0.7])

f_cutoff = 52;
f_stop = 68;
lpFilt = designfilt('lowpassfir','PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate',Fd);
fvtool(lpFilt)
filtered_x_sig_downsampled = Nfactor.*filter(lpFilt,xsig_sampled);
fre_filtered_x_sig_downsampled = fftshift(fft(filtered_x_sig_downsampled,length_xsig));

figure
plot(t, xsig, 'b')
hold on
plot(t, filtered_x_sig_downsampled, 'r')
grid on
legend('Original Spectrum', 'Recovered Signal')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.2])
ylim([-1.5 1.5])

figure
stem(f_sig, abs(fre_xsig)/length_xsig, 'b')
hold on
stem(f_sig, abs(fre_filtered_x_sig_downsampled)/length_xsig, 'r')
grid on
legend('Original Spectrum', 'Recovered Spectrum')
xlabel('Frequency (Hz)')
ylabel('Gain')
axis([-500 500 0 0.7])