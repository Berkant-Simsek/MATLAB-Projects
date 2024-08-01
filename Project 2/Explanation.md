The provided code is a MATLAB script used for audio signal processing. It performs the following 
functions: 
- Audio Input: 
  - The “audioread” function is used to read an audio file (“sound1.wav”) from a specified path. The output “audioIn” contains the audio data, and “fs” represents the sampling frequency of the audio. 
- Frequency Band Definitions: 
  - The “bassBand” is defined to capture frequencies from 0.01 Hz to 150 Hz. 
  - The “midBand” includes frequencies from 150 Hz to 4000 Hz. 
  - The “trebleBand” covers frequencies from 4000 Hz up to the minimum of 20000 Hz or half the sampling rate minus one. 
- Butterworth Bandpass Filters: 
  - Using the “butter” function, three bandpass filters are created for bass, mid, and treble frequencies. The filters are first-order (“1”), which means they have a gentle slope. 
- Filtering Audio: 
  - The “filter” function applies the created bandpass filters to the input audio, resulting in three separate audio signals: “audioBass”, “audioMid”, and “audioTreble”. 
- Gain Adjustment: 
  - The variables “bassGain”, “midGain”, and “trebleGain” are set to “1”, indicating no change in gain. However, these can be adjusted to increase or decrease the volume of the respective frequency bands. 
- Audio Mixing: 
  - The bass, mid, and treble signals are multiplied by their respective gains and then summed to create “equalizedAudio”. 
- Output: 
  - The “processedAudio” variable holds the final equalized audio signal. 
- Visualization: 
  - A time vector “t” is created for plotting. 
  - Two subplots are generated to visualize the original and processed audio waveforms, with time on the x-axis and amplitude on the y-axis. 
- Audio Playback: 
  - The “sound” function is used to play back the original and processed audio signals, with a pause in between to ensure they do not overlap.

The following section presents the graphs and explanations resulting from the modifications made to 
the MATLAB code provided earlier. These visualizations and accompanying descriptions aim to 
elucidate the effects of altering the bassGain, midGain, and trebleGain parameters on the audio signal’s 
waveform and the overall sound quality: 

- Bass Gain Increase: 
  - For the first adjustment, the bassGain was set to 15, while keeping the midGain and trebleGain at 1. This significantly amplified the bass frequencies in the audio signal, enriching the lower end of the spectrum and making the bass more pronounced in the output waveform. 
- Mid Gain Increase: 
  - In the second adjustment, the midGain was increased to 15, with the bassGain and trebleGain remaining at 1. This change emphasized the mid-range frequencies, which are crucial for the clarity and presence of the audio, especially for vocals and many instruments. 
- Treble Gain Increase: 
  - For the final adjustment, the trebleGain was raised to 15, while the bassGain and midGain were left at 1. This enhancement brought out the higher frequencies, adding brightness and crispness to the audio, which can improve the perception of detail and spatial cues in the sound. 

![image](https://github.com/user-attachments/assets/24c22a13-4454-4a07-9436-1c3192838ced)

![image](https://github.com/user-attachments/assets/7ef6060c-961b-45ae-b33c-08f784ede667)
