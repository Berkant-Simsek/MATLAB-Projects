M_array = [4,16,64];
M_calculation = [2,4,8];
Eb_No_array = 3:2:15;
output_Mqam_sim = zeros(length(M_array),length(Eb_No_array));
output_Mqam_theo = zeros(length(M_array),length(Eb_No_array));

for ii=1:length(M_array)
    M = M_array(ii);
    M_ = M_calculation(ii);
    for jj=1:length(Eb_No_array)
        Eb_No = Eb_No_array(jj);
        sim("Q1_");
        output_Mqam_sim(ii,jj) = ErrorVec(1); 
        input = 10^(Eb_No/10);
        output_Mqam_theo(ii,jj) = (2*(M_-1)/M_) * qfunc( sqrt(6*log2(M_)*input/((M_^2)-1)) )/log2(M_);    
    end
end

Eb_No_array = 3:2:15;
figure;
semilogy(Eb_No_array,output_Mqam_sim(1,:),'r*',DisplayName='QAM - Simulated BER')
hold on
semilogy(Eb_No_array,output_Mqam_theo(1,:),'r--o',DisplayName='QAM - Theoretical BER')
semilogy(Eb_No_array,output_Mqam_sim(2,:),'g*',DisplayName='16QAM - Simulated BER')
semilogy(Eb_No_array,output_Mqam_theo(2,:),'g--o',DisplayName='16QAM - Theoretical BER')
semilogy(Eb_No_array,output_Mqam_sim(3,:),'b*',DisplayName='64QAM - Simulated BER')
semilogy(Eb_No_array,output_Mqam_theo(3,:),'b--o',DisplayName='64QAM - Theoretical BER')
grid on
legend('Location','southwest')
xlabel("Eb/N0 (dB)");
ylabel("Bit Error Rate (BER)");
axis([2 20 10^-10 1])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



M_array = [4,8,16];
Eb_No_array = 3:2:15;
output_Mpsk_sim = zeros(length(M_array),length(Eb_No_array));
output_Mpsk_theo = zeros(length(M_array),length(Eb_No_array));

for ii=1:length(M_array)
    M = M_array(ii);
    for jj=1:length(Eb_No_array)
        Eb_No = Eb_No_array(jj);      
        sim("Q2_");
        output_Mpsk_sim(ii,jj) = ErrorVec(1);
        input = 10^(Eb_No/10);
        output_Mpsk_theo(ii,jj) = 2*qfunc(sqrt(2*log2(M)*input)*sin(pi/M))/log2(M);
    end
end

Eb_No_array = 3:2:15;
figure;
semilogy(Eb_No_array,output_Mpsk_sim(1,:),'r*',DisplayName='QPSK - Simulated BER')
hold on
semilogy(Eb_No_array,output_Mpsk_theo(1,:),'r--o',DisplayName='QPSK - Theoretical BER')
semilogy(Eb_No_array,output_Mpsk_sim(2,:),'g*',DisplayName='8PSK - Simulated BER')
semilogy(Eb_No_array,output_Mpsk_theo(2,:),'g--o',DisplayName='8PSK - Theoretical BER')
semilogy(Eb_No_array,output_Mpsk_sim(3,:),'b*',DisplayName='16PSK - Simulated BER')
semilogy(Eb_No_array,output_Mpsk_theo(3,:),'b--o',DisplayName='16PSK - Theoretical BER')
grid on
legend('Location','southwest')
xlabel("Eb/N0 (dB)");
ylabel("Bit Error Rate (BER)");
axis([2 20 10^-10 1])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Eb_No_array = 3:2:15;
output_16psk_sim = zeros(1,length(Eb_No_array));
output_16psk_theo = zeros(1,length(Eb_No_array));
output_16qam_sim = zeros(1,length(Eb_No_array));
output_16qam_theo = zeros(1,length(Eb_No_array));
M=16;
M_=4;

for jj=1:length(Eb_No_array)
    Eb_No = Eb_No_array(jj);
    sim("Q1_");
    output_16qam_sim(jj) = ErrorVec(1);
    input = 10^(Eb_No/10);
    output_16qam_theo(jj) = (2*(M_-1)/M_) * qfunc( sqrt(6*log2(M_)*input/((M_^2)-1)) )/log2(M_);
end

for jj=1:length(Eb_No_array)
    Eb_No = Eb_No_array(jj);
    sim("Q2_");
    output_16psk_sim(jj) = ErrorVec(1);
    input = 10^(Eb_No/10);
    output_16psk_theo(jj) = 2*qfunc(sqrt(2*log2(M)*input)*sin(pi/M))/log2(M);
end

Eb_No_array = 3:2:15;
figure;
semilogy(Eb_No_array,output_16psk_sim(:),'r*',DisplayName='16PSK - Simulated BER')
hold on
semilogy(Eb_No_array,output_16psk_theo(:),'r--o',DisplayName='16PSK - Theoretical BER')
semilogy(Eb_No_array,output_16qam_sim(:),'g*',DisplayName='16QAM - Simulated BER')
semilogy(Eb_No_array,output_16qam_theo(:),'g--o',DisplayName='16QAM - Theoretical BER')
grid on
legend('Location','southwest')
xlabel("Eb/N0 (dB)");
ylabel("Bit Error Rate (BER)");
axis([2 20 10^-10 1])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



M_array = [4, 16, 64];
M_calculation = [2, 4, 8];
Eb_No = 10;
input = 10^(Eb_No/10);
simulatedBER = zeros(1, length(M_array));
theoreticalBER = zeros(1, length(M_array));

for ii = 1:length(M_array)
    M = M_array(ii);
    M_ = M_calculation(ii);
    sim("Q1_");
    simulatedBER(ii) = ErrorVec(1);
    theoreticalBER(ii) = (2*(M_-1)/M_) * qfunc( sqrt(6*log2(M_)*input/((M_^2)-1)) ) / log2(M_);
end

for ii = 1:length(M_array)
    fprintf('%d-QAM -> Simulated BER: %.4e, Theoretical BER: %.4e\n', M_array(ii), simulatedBER(ii), theoreticalBER(ii));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



M_array = [4, 8, 16];
Eb_No = 10;
input = 10^(Eb_No/10);
simulatedBER = zeros(1, length(M_array));
theoreticalBER = zeros(1, length(M_array));

for ii = 1:length(M_array)
    M = M_array(ii);
    sim("Q2_");
    simulatedBER(ii) = ErrorVec(1);
    theoreticalBER(ii) = 2 * qfunc(sqrt(2 * log2(M) * input) * sin(pi / M)) / log2(M);
end

for ii = 1:length(M_array)
    fprintf('%d-PSK -> Simulated BER: %.4e, Theoretical BER: %.4e\n', M_array(ii), simulatedBER(ii), theoreticalBER(ii));
end