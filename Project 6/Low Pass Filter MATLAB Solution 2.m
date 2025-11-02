Fs = 500;
ts = 1/Fs;
T = 0.4;
t = 0:ts:T;
f1 = 25;
x1 = cos(2*pi*f1*t);
f2 = 75;
x2 = 2*cos(2*pi*f2*t);
x = x1+x2;

figure
plot(t,x1)
ylim([-4 4])
xlabel('Time')
grid on

figure
plot(t,x2)
ylim([-4 4])
xlabel('Time')
grid on

figure
plot(t,x)
ylim([-4 4])
xlabel('Time')
grid on

n=length(x);
fre_x1 = fftshift( fft(x1, n) );
fre_x2 = fftshift( fft(x2, n) );
fre_x = fftshift( fft(x, n) );
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_x1)/n)
axis([-250 250 0 1.25])
xlabel('Frequency')

figure
stem(f, abs(fre_x2)/n)
axis([-250 250 0 1.25])
xlabel('Frequency')

figure
stem(f, abs(fre_x)/n)
axis([-250 250 0 1.25])
xlabel('Frequency')

f_cutoff = 50;
f_stop = 60;
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate', Fs);
fvtool(lpFilt)
rec_x = filter(lpFilt,x);
fre_rx = fftshift(fft( rec_x, n ) );

figure
stem(f, abs(fre_x1)/n, 'bo')
hold on
stem(f, abs(fre_rx)/n, 'r*')
grid on
legend('Original x1 spectrum', 'Recovered x1 spectrum after LPF')
axis([-100 100 0 1.25])
xlabel('Frequency')
hold off

figure
plot(t, x1, 'b')
hold on
plot(t, rec_x, 'r')
grid on
axis([0 0.4 -3 3])
legend('Original x1', 'Recovered x1 after LPF')
xlabel('Time')
hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Fs = 500;
ts = 1/Fs;
f0 = 10;
T0 = 1/f0;
T = 1;
t = -T:ts:T;
y = square(2*pi*f0*(t+(T0/4)));
y = (y+1)/2;

figure
plot(t, y, LineWidth=2)
xlabel('Time')
xlim([-1 1])
ylim([-0.25 1.25])
grid on

k_harmonics = 10;
k_vec = -k_harmonics:k_harmonics;
cc = 1;
D = [];
m_approx = 0;

while cc<=length(k_vec)
    k= k_vec(cc);
    fun= @(x) exp(-j*2*pi*k*f0*x);
    FS_coeff(cc) = (1/T0)*(integral(fun,-T0/4,T0/4));
    D(cc) = abs(FS_coeff(cc));
    m_approx= m_approx + FS_coeff(cc)*exp(j*2*pi*k*f0*t);
    cc=cc+1;
end

n = length(y);
fre_y = fftshift( fft(y, n) );
f = (-(n-1)/2:(n-1)/2)*(Fs/n);

figure
stem(f, abs(fre_y)/n)
hold on
stem(k_vec*f0, D , "r-*", LineWidth=1)
xlabel('Frequency - Hz')
ylabel('Gain')
legend('Message Spectrum' ,sprintf('First %d coefficients', k_harmonics))
axis([-100 100 0 0.6])
grid on
hold off

f_cutoff = 40;
f_stop = 50;
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', f_cutoff, 'StopbandFrequency', f_stop, 'SampleRate', Fs);
rec_y = filter(lpFilt,y);
fre_ry = fftshift(fft( rec_y, n ) );

figure
stem(f, abs(fre_ry)/n)
grid on
axis([-50 50 0 0.5])
xlabel('Frequency - Hz')
ylabel('Gain')