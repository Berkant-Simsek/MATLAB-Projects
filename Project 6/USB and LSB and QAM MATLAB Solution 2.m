Fs = 1000;
ts = 1/Fs;
T = 1;
t = ts:ts:T;
f_x1 = 10;
f_x2 = 20;
f_x3 = 30;
T0_x1 = 1/f_x1;
T0_x2 = 1/f_x2;
T0_x3 = 1/f_x3;

x = cos(2*pi*f_x1*t) + 2*cos(2*pi*f_x2*t) + 4*cos(2*pi*f_x3*t);
n = length(x);
f = (-(n-1)/2:(n-1)/2)*(Fs/n);
fre_x = fftshift(fft(x, n));

figure
stem(f,abs(fre_x)/n)
xlabel('Frequency (Hz)')
title('Message Signal')
axis([-50 50 0 2.5])
grid on

fc = 100;
Tc = 1/fc;

modulated_signal = x .* cos(2*pi*fc*t);
n = length(modulated_signal);
fre_modulated = fftshift(fft(modulated_signal, n));

figure
stem(f,abs(fre_modulated)/n)
title('DSB-SC Spectrum')
axis([-250 250 0 1])
grid on

xh_signal = imag(hilbert(x));
s_usb = x .* cos(2*pi*fc*t) - xh_signal .* sin(2*pi*fc*t);
fre_s_usb = fftshift(fft(s_usb,n));

figure
stem(f,abs(fre_s_usb)/n)
title('USB Spectrum')
axis([-250 250 0 2])
grid on

s_lsb = x .* cos(2*pi*fc*t) + xh_signal .* sin(2*pi*fc*t);
fre_s_lsb = fftshift(fft(s_lsb,n));

figure
stem(f,abs(fre_s_lsb)/n)
title('LSB Spectrum')
axis([-250 250 0 2])
grid on

f_cutoff = 35;
f_stop = 65;
lpFilt = designfilt('lowpassfir','PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate',Fs);
fvtool(lpFilt)
r_usb = s_usb .* (2*cos(2*pi*fc*t));
r_lsb = s_lsb .* (2*cos(2*pi*fc*t));

%%%%%%%%%%%
n_r_usb = length(r_usb);
fre_r_usb = fftshift(fft(r_usb, n_r_usb));
f_r_usb = (-(n_r_usb-1)/2:(n_r_usb-1)/2)*(Fs/n_r_usb);

figure
stem(f_r_usb,abs(fre_r_usb)/n_r_usb)
axis([-250 250 0 2])
grid on


n_r_lsb = length(r_lsb);
fre_r_lsb = fftshift(fft(r_lsb, n_r_lsb));
f_r_lsb = (-(n_r_lsb-1)/2:(n_r_lsb-1)/2)*(Fs/n_r_lsb);

figure
stem(f_r_lsb,abs(fre_r_lsb)/n_r_lsb)
axis([-250 250 0 2])
grid on
%%%%%%%%%%%

filtered_signal_usb = filter(lpFilt,r_usb);
filtered_signal_lsb = filter(lpFilt,r_lsb);
fre_filtered_signal_usb = fftshift(fft(filtered_signal_usb,n));
fre_filtered_signal_lsb = fftshift(fft(filtered_signal_lsb,n));



figure
stem(f, abs(fre_x)/n, 'b')
hold on
stem(f, abs(fre_filtered_signal_usb)/n, 'rv')
legend('Original message spectrum', 'USB Recovered message spectrum')
xlabel('Frequency (Hz)')
axis([-100 100 0 2.5])
grid on

figure
stem(f, abs(fre_x)/n, 'b')
hold on
stem(f, abs(fre_filtered_signal_lsb)/n, 'rv')
legend('Original message spectrum', 'LSB Recovered message spectrum')
xlabel('Frequency (Hz)')
axis([-100 100 0 2.5])
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fs = 2000; 
ts = 1/Fs; 
f0 = 20;
T0 = 1/f0;
fc = 500;
T = 0.2;
t = ts:ts:T;

m1 = sawtooth(2*pi*f0*t);
m2 = square(2*pi*f0*t);

figure
plot(t, m1)
xlabel('Time (sec)')
xlim([0 0.2])
ylim([-1.5 1.5])
grid on

figure
plot(t, m2)
xlabel('Time (sec)')
xlim([0 0.2])
ylim([-1.5 1.5])
grid on

s_qam = m1 .* cos(2*pi*fc*t) + m2 .* sin(2*pi*fc*t);

figure
plot(t, s_qam)
xlabel('Time (sec)')
xlim([0 0.05])
ylim([-1.5 1.5])
grid on

% n = length(s_qam);
% f = (-(n-1)/2:(n-1)/2)*(Fs/n);
% fre_Sqam = fftshift(fft(s_qam, n));
% 
% figure(1)
% stem(f,abs(fre_Sqam)/n)
% xlabel('Frequency (Hz)')
% title('Message Signal')
% axis([0 0.2 -1.5 1.5])

f_cutoff = 100;
f_stop = 120;
lpFilt = designfilt('lowpassfir','PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate',Fs);
fvtool(lpFilt)
r1 = s_qam .* (2*cos(2*pi*fc*t));
r2 = s_qam .* (2*sin(2*pi*fc*t));
filtered_m1 = filter(lpFilt,r1);
filtered_m2 = filter(lpFilt,r2);
% fre_filtered_m1 = fftshift(fft(filtered_m1,n));
% fre_filtered_m2 = fftshift(fft(filtered_m2,n));

figure
plot(t, m2, 'b')
hold on
plot(t, filtered_m2, 'r')
grid on
xlabel('Time (sec)')
xlim([0 0.2])
ylim([-1.5 1.5])

figure
plot(t, m1, 'b')
hold on
plot(t, filtered_m1, 'r')
grid on
xlabel('Time (sec)')
xlim([0 0.2])
ylim([-1.5 1.5])