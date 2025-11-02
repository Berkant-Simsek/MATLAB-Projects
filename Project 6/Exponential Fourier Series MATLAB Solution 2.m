Fs = 1000;
ts = 1/Fs;
T = 2;
f0 = 1;
T0 = 1/f0;
t = -T:ts:T;
x = square(2*pi*f0*(t+(T0/4)));
x = (x+1)/2;

figure
plot(t, x, LineWidth=2)
xlabel('Time (sec.)')
ylabel('Amplitude')
xlim([-2 2])
ylim([-0.5 2])
legend("Message Signal")
title('Figure 1 – Periodic Square Signal')
grid on

k_harmonics = 10;
k_vec = -k_harmonics:k_harmonics;
cc = 1;
D = [];
m_approx = 0;

while cc<=length(k_vec)
    k = k_vec(cc);
    fun = @(time) exp(-j*2*pi*k*f0*time);
    FS_coeff(cc) = (1/T0)*integral(fun, -T0/4, T0/4);
    D(cc) = abs(FS_coeff(cc));
    m_approx = m_approx + FS_coeff(cc)*exp(j*2*pi*k*f0*t);
    cc = cc + 1;
end

figure
stem(k_vec*f0, D, "r-*", LineWidth=1)
xlabel('Frequency - Hz');
ylabel('Gain');
legend(sprintf("First %d Coefficients", k_harmonics))
grid on

figure
plot(t, x, LineWidth=2)
hold on
plot(t, real(m_approx), 'r', LineWidth=1)
xlabel('Time (sec.)')
ylabel('Amplitude')
ylim([-0.5 2])
legend("Original Signal", sprintf("%d Harmonic Approximation", k_harmonics))
grid on
hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fs = 1000;
ts = 1/Fs;
T = 2;
f0 = 1;
T0 = 1/f0;
t = -T:ts:T;
y = sawtooth(2*pi*f0*(t+(T0/2)));

figure
plot(t, y, LineWidth=2)
xlabel('Time (sec.)')
ylabel('Amplitude')
xlim([-2 2])
ylim([-2 2])
legend("Message Signal")
title('Figure 2 - Periodic Sawtooth Signal')
grid on

k_harmonics = 10;
k_vec = -k_harmonics:k_harmonics;
cc = 1;
D = [];
m_approx = 0;

while cc<=length(k_vec)
    k = k_vec(cc);
    fun = @(time) (2/T0)*time.*exp(-j*2*pi*k*f0*time);
    FS_coeff(cc) = (1/T0)*integral(fun, -T0/2, T0/2);
    D(cc) = abs(FS_coeff(cc));
    m_approx = m_approx + FS_coeff(cc)*exp(j*2*pi*k*f0*t);
    cc = cc + 1;
end

figure
stem(k_vec*f0, D, 'r-*', LineWidth=1)
xlabel('Frequency - Hz')
ylabel('Gain')
legend(sprintf("First %d Coefficients", k_harmonics))
grid on

figure
plot(t, y, LineWidth=2)
hold on
plot(t, real(m_approx), 'r', LineWidth=1)
grid on
xlabel('Time (sec.)')
ylabel('Amplitude')
ylim([-2 2])
legend("Original Signal", sprintf("%d Harmonic Approximation", k_harmonics))
hold off