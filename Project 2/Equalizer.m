[audioIn, fs] = audioread('C:\sound1.wav'); 
bassBand = [0.01 150] / (fs/2); 
midBand = [150 4000] / (fs/2); 
trebleBand = [4000 min(20000, fs/2-1)] / (fs/2); 
[bassB, bassA] = butter(1, bassBand, 'bandpass'); 
[midB, midA] = butter(1, midBand, 'bandpass'); 
[trebleB, trebleA] = butter(1, trebleBand, 'bandpass'); 
audioBass = filter(bassB, bassA, audioIn); 
audioMid = filter(midB, midA, audioIn); 
audioTreble = filter(trebleB, trebleA, audioIn); 

bassGain = 1; 
midGain = 1; 
trebleGain = 1; 

audioBass = audioBass * bassGain; 
audioMid = audioMid * midGain; 
audioTreble = audioTreble * trebleGain; 
equalizedAudio = audioBass + audioMid + audioTreble; 
processedAudio = equalizedAudio; 

t = (0:length(audioIn)-1)/fs; 
figure; 
subplot(2,1,1); 
plot(t, audioIn); 
title('Original Audio Waveform'); 
xlabel('Time (seconds)'); 
ylabel('Amplitude'); 
xlim([0 max(t)]); 
ylim([-8 8]); 
subplot(2,1,2); 
plot(t, processedAudio); 
title('Processed Audio Waveform'); 
xlabel('Time (seconds)'); 
ylabel('Amplitude'); 
xlim([0 max(t)]); 
ylim([-8 8]); 

sound(audioIn, fs); 
pause(length(audioIn)/fs + 1); 
sound(processedAudio, fs); 
