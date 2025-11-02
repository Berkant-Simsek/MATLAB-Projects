Fs = 1000;
ts = 1/Fs;
T = 0.4;
t = ts:ts:T;
f1 = 30;
x1 = cos(2*pi*f1*t);

figure
plot(t,x1)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Time Domain Representation of x1')
grid on

n = length(x1);
fre_x1 = fftshift( fft(x1, n) );
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_x1)/n)
axis([-100 100 0 0.5])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Domain Representation of x1')
legend('Message Signal in Frequency Domain')
grid on

A = 2/3; %1, 2, 2/3
fc = 200;
c = cos(2*pi*fc*t);
AM_signal = (A + x1) .* c;
% AM_signal = (1 + x1_index*x1).*c;

figure
plot(t, AM_signal)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('AM Signal in Time Domain')
grid on

n = length(AM_signal);
fre_AM = fftshift( fft(AM_signal, n) );
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_AM)/n)
axis([-350 350 0 1])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('AM Signal in Frequency Domain')
grid on

envelope_AM = envelope(AM_signal);

figure
plot(t, AM_signal)
hold on
plot(t, envelope_AM, 'r', 'LineWidth', 1)
hold off
xlabel('Time (s)')
ylabel('Amplitude')
axis([0 0.25 -3 3])
title('AM Signal and Envelope in Time Domain')
legend('AM Signal in Time Domain', 'Envelope Detector Output')
grid on

recovered_signal = envelope_AM - mean(envelope_AM);

figure
plot(t, x1, 'b')
hold on
plot(t, recovered_signal, 'ro', 'LineWidth', 1)
hold off
axis([0 0.25 -2 2])
xlabel('Time (s)')
ylabel('Amplitude')
title('Original and Recovered Message Signals in Time Domain')
legend('Message Signal in Time Domain', 'Recovered Signal in Time Domain')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fc_new = 150;
c_new = cos(2*pi*fc_new*t);
AM_signal_shifted = (A + x1) .* c_new;
% AM_signal_shifted = (1 + x1_index*x1).*c_new;

figure
plot(t, AM_signal_shifted)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Shifted AM Signal in Time Domain')
grid on

n = length(AM_signal_shifted);
fre_AM_shifted = fftshift( fft(AM_signal_shifted, n) );
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_AM_shifted)/n)
axis([-350 350 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Shifted AM Signal in Frequency Domain')
grid on

envelope_AM_shifted = envelope(AM_signal_shifted);

figure
plot(t, AM_signal_shifted)
hold on
plot(t, envelope_AM_shifted, 'r', 'LineWidth', 1)
hold off
xlabel('Time (s)')
ylabel('Amplitude')
axis([0 0.25 -2 2])
title('Shifted AM Signal and Envelope in Time Domain')
legend('Shifted AM Signal in Time Domain', 'Envelope Detector Output')
grid on

recovered_shifted_signal = envelope_AM_shifted - mean(envelope_AM_shifted);

figure
plot(t, x1, 'b')
hold on
plot(t, recovered_shifted_signal, 'ro', 'LineWidth', 1)
hold off
axis([0 0.25 -2 2])
xlabel('Time (s)')
ylabel('Amplitude')
title('Original and Recovered Message Signals in Time Domain')
legend('Message Signal in Time Domain', 'Recovered Signal in Time Domain')
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fs = 1000;
ts = 1/Fs;
T = 0.4;
t = ts:ts:T;
f1 = 30;
x1 = cos(2*pi*f1*t);

fc = 100;
c = cos(2*pi*fc*t);
DSB_SC_signal = x1 .* c;

figure
plot(t, DSB_SC_signal)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('DSB-SC AM Signal in Time Domain')
grid on

n = length(DSB_SC_signal);
fre_DSB_SC = fftshift(fft(DSB_SC_signal, n));
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_DSB_SC)/n)
axis([-350 350 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('DSB-SC AM Signal in Frequency Domain')
grid on

demo_DSB_SC_signal = 2 .* DSB_SC_signal .* c;

figure
plot(t, demo_DSB_SC_signal)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Demodulation DSB-SC AM Signal in Time Domain')
grid on

n = length(demo_DSB_SC_signal);
fre_demo_DSB_SC = fftshift(fft(demo_DSB_SC_signal, n));
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_demo_DSB_SC)/n)
axis([-500 500 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Demodulation DSB-SC AM Signal in Frequency Domain')
grid on

f_cutoff = 45;
f_stop = 55;
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate', Fs);
rec_demo_DSB_SC_signal = filter(lpFilt,demo_DSB_SC_signal);
fre_rdemo_DSB_SC_signal = fftshift(fft( rec_demo_DSB_SC_signal, n ) );

figure
stem(f, abs(fre_rdemo_DSB_SC_signal)/n)
axis([-500 500 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Demodulation DSB-SC AM Signal in Frequency Domain after Low Pass Filter')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fc_new = 150;
c_new = cos(2*pi*fc_new*t);
DSB_SC_signal_shifted = x1 .* c_new;

figure
plot(t, DSB_SC_signal_shifted)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Shifted DSB-SC AM Signal in Time Domain')
grid on

n = length(DSB_SC_signal_shifted);
fre_DSB_SC_shifted = fftshift(fft(DSB_SC_signal_shifted, n));
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_DSB_SC_shifted)/n)
axis([-350 350 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Shifted DSB-SC AM Signal in Frequency Domain')
grid on

demo_DSB_SC_signal_shifted = 2 .* DSB_SC_signal_shifted .* c_new;

figure
plot(t, demo_DSB_SC_signal_shifted)
axis([0 0.4 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Demodulation Shifted DSB-SC AM Signal in Time Domain')
grid on

n = length(demo_DSB_SC_signal_shifted);
fre_demo_DSB_SC_shifted = fftshift(fft(demo_DSB_SC_signal_shifted, n));
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_demo_DSB_SC_shifted)/n)
axis([-500 500 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Demodulation Shifted DSB-SC AM Signal in Frequency Domain')
grid on

f_cutoff = 45;
f_stop = 55;
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate', Fs);
rec_demo_DSB_SC_signal_shifted = filter(lpFilt,demo_DSB_SC_signal_shifted);
fre_rdemo_DSB_SC_signal_shifted = fftshift(fft( rec_demo_DSB_SC_signal_shifted, n ) );

figure
stem(f, abs(fre_rdemo_DSB_SC_signal_shifted)/n)
axis([-500 500 0 0.6])
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Demodulation Shifted DSB-SC AM Signal in Frequency Domain after Low Pass Filter')
grid on