clear all;

%Set Sampling Frequency and Note Frequency and buffer length
fs = 44100; %Hertz
note = 640; %Hertz
bufferLength = 10000; %Samples

%Print Delay in ms
delayS = (bufferLength/fs);
delayMS = delayS*1000

%Create Sine
%Calculate Cycles of note per bufferLength
numCycles = note*delayS;
t = numCycles*2*pi/bufferLength:numCycles*2*pi/bufferLength:numCycles*2*pi;
sineTDomain = cos(t);

%Take FFTs
fftCenter = bufferLength/2 + 1;
FrequencyPerSample = fs/bufferLength;

fftSine = fftshift(fft(ifftshift(sineTDomain)));
absFFTSine = abs(fftSine);

figure;
plot(sineTDomain);
figure;
plot(absFFTSine);

%Find Note Frequency
threshold = 20; %Note must exceed this threshold energy to be registered as note
                %ToDo: Use this value and figure out how to calculate it

maxValue = 0;
maxValueAt = 0;
for i=1 : bufferLength
    if maxValue < absFFTSine(i)
        maxValueAt = i;
        maxValue = absFFTSine(i);
    end
end

%Calculate Note
distFromCenter = abs(maxValueAt - fftCenter);
foundNote = distFromCenter*FrequencyPerSample