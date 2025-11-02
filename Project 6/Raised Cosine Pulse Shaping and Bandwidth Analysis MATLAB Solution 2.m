%% Parameters
T = 0.01;                    % Symbol duration (10 ms)
R = 1 / T;                   % Symbol rate = 100 symbols/sec
sampsPerSym = 10;            % Samples per symbol
Fs = R * sampsPerSym;        % Sampling frequency
Nsym = 6;                    % Filter span in symbols
DataL = 15;                  % Number of symbols
beta_values = [0.1, 0.5, 1.0];                  % Only one beta value
colors = ['b', 'r', 'g'];
tx = (0:DataL - 1) * T;      % Symbol time vector in seconds

%% Generate random bipolar data
rng(0);
x = 2 * randi([0 1], DataL, 1) - 1;

for b_idx = 1:length(beta_values)
    beta = beta_values(b_idx);

    %% Raised Cosine Filter
    rctFilt = comm.RaisedCosineTransmitFilter( ...
        'Shape','Square root', ...
        'RolloffFactor', beta, ...
        'FilterSpanInSymbols', Nsym, ...
        'OutputSamplesPerSymbol', sampsPerSym);

    % Normalize gain
    b = coeffs(rctFilt);
    rctFilt.Gain = 1 / max(b.Numerator);

    % Filter signal
    yo = rctFilt([x; zeros(Nsym/2,1)]);
    fltDelay = Nsym / (2 * R);
    yo = yo(fltDelay * Fs + 1:end);

    %% Time vector for output
    to = (0:length(yo)-1) / Fs;

    %% PSD calculation
    [Pxx, f] = pwelch(yo, [], [], [], Fs); % one-sided
    Pnorm = Pxx / sum(Pxx);
    cumPxx = cumsum(Pnorm);
    idx_cut = find(cumPxx >= 0.99, 1);
    BW_99 = f(idx_cut); % one-sided 99% bandwidth
    BW_theoretical = (1 + beta) / (2 * T);

    %% === Figure 1: Time Domain (First 10 Symbols) ===
    figure(1); hold on;
    stem(tx(1:10), x(1:10), 'kx', 'DisplayName','Original');
    plot(to(1:10 * sampsPerSym), yo(1:10 * sampsPerSym), ...
        colors(b_idx), 'LineWidth', 1.5, 'DisplayName', sprintf('\\beta = %.1f', beta));
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Location', 'southeast');
    title('First 10 Symbols - Time Domain');
    axis tight; grid on;

    %% === Figure 2: PSD with Bandwidth Annotation ===
    figure(2); hold on;
    plot(f, 10 * log10(Pxx / max(Pxx)), colors(b_idx), 'LineWidth', 1.5, ...
        'DisplayName', sprintf('\\beta = %.1f (BW_{99%%} = %.2f Hz, BW_{th} = %.2f Hz)', ...
        beta, BW_99, BW_theoretical));
    xline(BW_99, [':', colors(b_idx)], 'LineWidth', 1.0);
    xlabel('Frequency (Hz)'); ylabel('Normalized PSD (dB)');
    title('One-Sided Welch PSD with Bandwidth');
    xlim([0 100]); ylim([-60 5]); grid on; axis tight;

    % Console output
    fprintf('Beta = %.1f --> One-sided 99%% BW = %.2f Hz, Theoretical BW = %.2f Hz\n', ...
        beta, BW_99, BW_theoretical);

    %% === Figure 3: Eye Diagram ===
    eyediagram(yo, 2 * sampsPerSym);
    title(sprintf('Eye Diagram (\\beta = %.1f)', beta));
end

figure(2);
legend('Location', 'northeast');