Eb_N0 = 10;
EbNo_dB = 3:12;
Eb_N0_linear = 10^(Eb_N0/10); 

sim('simulink_model_q1_v1');
simulatedBER_bpam = ErrorVec(1);
theoreticalBER_bpam = qfunc(sqrt(2*Eb_N0_linear));

fprintf('Simulated BER: %e\n', simulatedBER_bpam);
fprintf('Theoretical BER: %e\n', theoreticalBER_bpam);



simulatedBER = zeros(size(EbNo_dB));
theoreticalBER = zeros(size(EbNo_dB));

model = 'simulink_model_q1_v1';
load_system(model);

for i = 1:length(EbNo_dB)
    EbNo = EbNo_dB(i);
    
    set_param([model '/AWGN Channel'], 'EbNodB', num2str(EbNo));

    sim(model);
 
    simulatedBER(i) = ErrorVec(1);
    
    EbNo_lin = 10^(EbNo/10); 
    theoreticalBER(i) = qfunc(sqrt(2*EbNo_lin));
end

close_system(model, 0);

figure;
semilogy(EbNo_dB, simulatedBER, 'r*', 'LineWidth', 1);
hold on;
semilogy(EbNo_dB, theoreticalBER, 'bo-', 'LineWidth', 1);
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BER', 'Theoretical BER');
title('BER vs. Eb/N0 for BPSK');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



M_array = [2,4,8];
Eb_NoArray = 3:2:15;
outputMpamSim = zeros(length(Eb_NoArray),length(M_array));
outputMpamTheo = zeros(length(Eb_NoArray),length(M_array));

model = 'simulink_model_q2';
load_system(model);

for ii=1:length(M_array)
    M = M_array(ii);
    for jj=1:length(Eb_NoArray)
        Eb_No = Eb_NoArray(jj);
        sim("simulink_model_q2.slx");
        outputMpamSim(ii,jj) = ErrorVec(1); 
        input = 10^(Eb_No/10);
        outputMpamTheo(ii,jj) = ((2*(M-1))/(M*log2(M))) * qfunc(sqrt((6*log2(M)*input)/((M^2)-1)));      
    end
end

% Close the Simulink model
close_system(model, 0);

% Plotting BER vs Eb/N0
figure;
semilogy(Eb_NoArray,outputMpamSim(1,:),'r*')
hold on
semilogy(Eb_NoArray,outputMpamTheo(1,:),'r--o')
semilogy(Eb_NoArray,outputMpamSim(2,:),'b*')
semilogy(Eb_NoArray,outputMpamTheo(2,:),'b--o')
semilogy(Eb_NoArray,outputMpamSim(3,:),'g*')
semilogy(Eb_NoArray,outputMpamTheo(3,:),'g--o')
grid on;
xlabel('E_b / N_0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BPAM', 'Theoretical BPAM', ...
    'Simulated 4PAM', 'Theoretical 4PAM', ...
    'Simulated 8PAM', 'Theoretical 8PAM');
title('BER vs. E_b / N_0 for M-PAM');



N = 1e6; 
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

fprintf('Simulated BER: %f\n', BER_sim);
fprintf('Theoretical BER: %f\n', BER_theo);



N = 1e6;
N0 = 2;
EbN0_dB = 3:2:15;
Eb_values = N0 * 10.^(EbN0_dB/10);

BER_sim_bpam = zeros(1, length(Eb_values));
BER_theo_bpam = zeros(1, length(Eb_values));
BER_sim_4pam = zeros(1, length(Eb_values));
BER_theo_4pam = zeros(1, length(Eb_values));
BER_sim_8pam = zeros(1, length(Eb_values));
BER_theo_8pam = zeros(1, length(Eb_values));


for i = 1:length(Eb_values)
    Eb = Eb_values(i);
    
    bits = randi([0 1], 1, N);
    n = sqrt(N0/2) * randn(1, N);
    
    s_bpam = (2*bits - 1) * sqrt(Eb);
    r_bpam = s_bpam + n;
    dec_bits_bpam = r_bpam > 0;
    num_errors_bpam = sum(bits ~= dec_bits_bpam);
    BER_sim_bpam(i) = num_errors_bpam / N;
    BER_theo_bpam(i) = qfunc(sqrt(2*Eb/N0));
    
    s_4pam = (2*bits - 1) * sqrt(Eb/3);
    r_4pam = s_4pam + n;
    dec_bits_4pam = r_4pam > 0;
    num_errors_4pam = sum(bits ~= dec_bits_4pam);
    BER_sim_4pam(i) = num_errors_4pam / N;
    BER_theo_4pam(i) = (3*qfunc(sqrt((12*Eb)/(15*N0))))/4;
    
    s_8pam = (2*bits - 1) * sqrt(Eb/7);
    r_8pam = s_8pam + n;
    dec_bits_8pam = r_8pam > 0;
    num_errors_8pam = sum(bits ~= dec_bits_8pam);
    BER_sim_8pam(i) = num_errors_8pam / N;
    BER_theo_8pam(i) = (7*qfunc(sqrt((18*Eb)/(63*N0))))/12;
end

% Convert Eb/N0 to dB
% EbN0_dB = 10 * log10(Eb_values / N0);

% Plot results
figure;
semilogy(EbN0_dB, BER_sim_bpam, 'r*', ...
    EbN0_dB, BER_theo_bpam, 'r--o', ...
    EbN0_dB, BER_sim_4pam, 'b*', ...
    EbN0_dB, BER_theo_4pam, 'b--o', ...
    EbN0_dB, BER_sim_8pam, 'g*', ...
    EbN0_dB, BER_theo_8pam, 'g--o');
grid on
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated BPAM', 'Theoretical BPAM', ...
    'Simulated 4PAM', 'Theoretical 4PAM', ...
    'Simulated 8PAM', 'Theoretical 8PAM');