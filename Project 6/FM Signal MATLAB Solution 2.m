Fs = 10000;
ts = 1/Fs;
T = 1;
t = ts:ts:T;
mp = 1;
fm = 10;
fc = 300;
kf = 200*pi;

delta_f = (kf*mp)/(2*pi);
fmax = fc + delta_f;
fmin = fc - delta_f;
message = mp*cos(2*pi*fm*t);
m_intg = ts*cumsum(message);
Fm_signal = cos(2*pi*fc*t + kf*m_intg);

figure
plot(t, message, 'r', 'LineWidth', 2)
hold on
plot(t, Fm_signal, 'b', 'LineWidth', 1)
legend('Message Signal','FM Signal')
axis([0 0.2 -1.5 1.5])
hold off
grid on

n = length(Fm_signal);
frequency = -(n-1)/2:(n-1)/2*(Fs/n);
fre_Fm_Signal = fftshift(fft(Fm_signal, n));

figure
stem(frequency,abs(fre_Fm_Signal)/n)
xlabel('Frequency (Hz)')
axis([-800 800 0 0.16])
grid on

s_der = diff([Fm_signal(1) Fm_signal])/ts/kf;
mrec = envelope(s_der);

figure
plot(t, s_der, 'b', 'LineWidth', 1)
hold on
plot(t, mrec, 'r', 'LineWidth', 2)
legend('Output of the differantiator','Envelope detector output')
axis([0 0.2 -4 5])
hold off
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fs = 10000;
ts = 1/Fs;
T = 1;
t = ts:ts:T;
fc = 300;
kf = 200*pi;
mp_2 = 2;
fm_2 = 10;
message2 = mp_2*cos(2*pi*fm_2*t);
m_intg2 = ts*cumsum(message2);
Fm_signal2 = cos(2*pi*fc*t + kf*m_intg2);

figure
plot(t,message2,'r','LineWidth',2)
hold on
plot(t,Fm_signal2,'b','LineWidth',1)
legend('Message Signal','FM Signal')
axis([0 0.2 -3 3])
hold off

n = length(Fm_signal2);
frequency = -(n-1)/2:(n-1)/2*(Fs/n);
fre_Fm_Signal2 = fftshift(fft(Fm_signal2, n));

figure
stem(frequency,abs(fre_Fm_Signal2)/n)
xlabel('Frequency (Hz)')
axis([-800 800 0 0.15])

s_der2 = diff([Fm_signal2(1) Fm_signal2])/ts/kf;
mrec2 = envelope(s_der2);

figure
plot(t,s_der2,'b','LineWidth',1)
hold on
plot(t,mrec2,'r','LineWidth',2)
legend('Output of the differantiator','Envelope detector output')
axis([0 0.2 -10 10])
hold off

mp_3 = 1;
fm_3 = 20;
message3 = mp_3*cos(2*pi*fm_3*t);
m_intg3 = ts*cumsum(message3);
Fm_signal3 = cos(2*pi*fc*t + kf*m_intg3);

figure
plot(t,message3,'r','LineWidth',2)
hold on
plot(t,Fm_signal3,'b','LineWidth',1)
legend('Message Signal','FM Signal')
axis([0 0.2 -1.5 1.5])
hold off 

n = length(Fm_signal3);
frequency = -(n-1)/2:(n-1)/2*(Fs/n);
fre_Fm_Signal3 = fftshift(fft(Fm_signal3, n));

figure
stem(frequency,abs(fre_Fm_Signal3)/n)
xlabel('Frequency (Hz)')
axis([-800 800 0 0.2])

s_der3 = diff([Fm_signal3(1) Fm_signal3])/ts/kf;
mrec3 = envelope(s_der3);

figure
plot(t,s_der3,'b','LineWidth',1)
hold on
plot(t,mrec3,'r','LineWidth',2)
legend('Output of the differantiator','Envelope detector output')
axis([0 0.2 -4 4])
hold off
