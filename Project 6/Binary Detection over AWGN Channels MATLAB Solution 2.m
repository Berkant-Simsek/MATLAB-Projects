N = 10e5;
Eb = 10;
N0 = 2;

bits = randi([0 1], 1, N);
s = 2*bits - 1;
s = s * sqrt(Eb);
n = sqrt(N0/2) * randn(1, N);
r = s + n;
dec_bits = r > 0;
num_errors = sum(bits ~= dec_bits);
BER_sim = num_errors / N;

BER_theo = qfunc(sqrt(2*Eb/N0));

fprintf('Simulated Polar BER: %f\n', BER_sim);
fprintf('Theoretical Polar BER: %f\n', BER_theo);



N = 10e5;
Eb = 10;
N0 = 2;
A = sqrt(2*Eb);

bits = randi([0 1], 1, N);
s = A * bits;
n = sqrt(N0/2) * randn(1, N);
r = s + n;
threshold = A / 2;
dec_bits = r > threshold;
num_errors = sum(bits ~= dec_bits);
BER_sim = num_errors / N;

BER_theo = qfunc(sqrt(Eb/N0));

fprintf('Simulated On-Off BER: %f\n', BER_sim);
fprintf('Theoretical On-Off BER: %f\n', BER_theo);



N = 10e5; 
N0 = 2; 
Eb_values = 4:1:20;
BER_sim_polar = zeros(1, length(Eb_values));
BER_theo_polar = zeros(1, length(Eb_values));
BER_sim_onoff = zeros(1, length(Eb_values));
BER_theo_onoff = zeros(1, length(Eb_values));

for i = 1:length(Eb_values)
    Eb = Eb_values(i);
    A = sqrt(2*Eb);
    
    bits = randi([0 1], 1, N);
    s_polar = (2*bits - 1) * sqrt(Eb);
    n = sqrt(N0/2) * randn(1, N);
    r_polar = s_polar + n;
    dec_bits_polar = r_polar > 0;
    num_errors_polar = sum(bits ~= dec_bits_polar);
    BER_sim_polar(i) = num_errors_polar / N;
    BER_theo_polar(i) = qfunc(sqrt(2*Eb/N0));
    
    s_onoff = A * bits;
    r_onoff = s_onoff + n;
    threshold = A / 2;
    dec_bits_onoff = r_onoff > threshold;
    num_errors_onoff = sum(bits ~= dec_bits_onoff);
    BER_sim_onoff(i) = num_errors_onoff / N;
    BER_theo_onoff(i) = qfunc(sqrt(Eb/N0));
end

EbN0_dB = 10 * log10(Eb_values / (N0));

figure;
semilogy(EbN0_dB, BER_sim_polar, 'bo', EbN0_dB, BER_theo_polar, 'r-*');
hold on;
semilogy(EbN0_dB, BER_sim_onoff, 'gs', EbN0_dB, BER_theo_onoff, 'k-^');
hold off;
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BER - Polar', 'Theoretical BER - Polar', 'Simulated BER - OOK', 'Theoretical BER - OOK');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Pr = 10e-3;
Rb = 5000;
N0 = 2 * 10e-6;
N = 10e5;
Eb = Pr / Rb;
A = sqrt(2*Eb);

bits = randi([0 1], 1, N);
s_polar = (2*bits - 1) * sqrt(Eb);
n = sqrt(N0/2) * randn(1, N);
r_polar = s_polar + n;
dec_bits_polar = r_polar > 0;
num_errors_polar = sum(bits ~= dec_bits_polar);
BER_sim_polar = num_errors_polar / N;

BER_theo_polar = qfunc(sqrt(2*Eb/N0));

fprintf('Simulated Polar BER: %f\n', BER_sim_polar);
fprintf('Theoretical Polar BER: %f\n', BER_theo_polar);



s_onoff = A * bits;
r_onoff = s_onoff + n;
threshold = A / 2;
dec_bits_onoff = r_onoff > threshold;
num_errors_onoff = sum(bits ~= dec_bits_onoff);
BER_sim_onoff = num_errors_onoff / N;

BER_theo_onoff = qfunc(sqrt(Eb/N0));

fprintf('Simulated On-Off BER: %f\n', BER_sim_onoff);
fprintf('Theoretical On-Off BER: %f\n', BER_theo_onoff);



Pr = 10e-3;
Rb_values = 500:500:5000;
N0 = 2 * 10e-6;
N = 10e5;

BER_sim_polar_Rb = zeros(1, length(Rb_values));
BER_theo_polar_Rb = zeros(1, length(Rb_values));
BER_sim_onoff_Rb = zeros(1, length(Rb_values));
BER_theo_onoff_Rb = zeros(1, length(Rb_values));

for i = 1:length(Rb_values)
    Rb = Rb_values(i);
    Eb = Pr / Rb;
    EbN0 = Eb / N0;
    A = sqrt(2*Eb);

    bits = randi([0 1], 1, N);
    s_polar = (2*bits - 1) * sqrt(Eb);
    n = sqrt(N0/2) * randn(1, N);
    r_polar = s_polar + n;
    dec_bits_polar = r_polar > 0;
    num_errors_polar = sum(bits ~= dec_bits_polar);
    BER_sim_polar_Rb(i) = num_errors_polar / N;
    BER_theo_polar_Rb(i) = qfunc(sqrt(2*EbN0));

    s_onoff = A * bits;
    r_onoff = s_onoff + n;
    threshold = A / 2;
    dec_bits_onoff = r_onoff > threshold;
    num_errors_onoff = sum(bits ~= dec_bits_onoff);
    BER_sim_onoff_Rb(i) = num_errors_onoff / N;
    BER_theo_onoff_Rb(i) = qfunc(sqrt(EbN0));
end

figure;
semilogy(Rb_values, BER_sim_polar_Rb, 'bo-', Rb_values, BER_theo_polar_Rb, 'r--');
hold on;
semilogy(Rb_values, BER_sim_onoff_Rb, 'gs-', Rb_values, BER_theo_onoff_Rb, 'k--');
hold off;
grid on;
xlabel('Data Rate R_b (bps)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BER - Polar', 'Theoretical BER - Polar', 'Simulated BER - OOK', 'Theoretical BER - OOK');