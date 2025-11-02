n = 1e6;
A = 5;
nvar = 4; 

x = A + sqrt(nvar)*randn(1,n);
hist(x,20)
xlabel("Random Variable")
ylabel("Number of occurances")

p_7_34t = qfunc((7.34-5)/2);
p_3_81t = 1 - qfunc((3.81-5)/2);
p_1_87_and_3_49_t = qfunc((1.87-5)/2)- qfunc((3.49-5)/2);
fprintf('P(X > 7.34) = %.4d\n',p_7_34t);
fprintf('P(X < 3.81) = %.4d\n',p_3_81t);
fprintf('P(1.87 < X < 3.49) = %.4d\n',p_1_87_and_3_49_t);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



N = 1e6; 
q = 0.2;  
A = 5; 
nvar = 4;

info_bits = double(rand(1, N) > (1 - q));
tx_symbols = 2 * info_bits - 1;
noise_samples = sqrt(nvar) * randn(1, N);
x = A * tx_symbols + noise_samples;
hist(x,20)
xlabel("Random Variable")
ylabel("Number of occurances")

Psim = zeros(1, 41);
Pthe = zeros(1, 41);
T_values = -10:0.5:10; 

for i = 1:length(T_values)
    T = T_values(i);
    rec_bits = double(x > T);
    Psim(i) = sum(xor(info_bits, rec_bits)) / N;
    Pthe(i) = qfunc((T + A) / sqrt(nvar)) * (1 - q) + qfunc((A - T) / sqrt(nvar)) * q;
end

[optimal_Psim, optimal_idx] = min(Psim);
optimal_T = T_values(optimal_idx);

figure;
semilogy(T_values, Psim, 'b-o', T_values, Pthe, 'r-*');
hold on;
plot([optimal_T optimal_T], [10^-4 10^0], 'r', 'LineWidth', 1);
plot(xlim, [optimal_Psim optimal_Psim], 'k', 'LineWidth', 1);
hold off;
xlabel('Threshold');
ylabel('Probability of Error');
legend('Simulated BER', 'Theoretical BER', 'Optimal Threshold', 'Min. Probability');
grid on;
% text(optimal_T, optimal_Psim, sprintf('Min Probability\n(%.2e)', optimal_Psim), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');