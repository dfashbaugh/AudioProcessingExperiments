clear all;

%Set Sampling Frequency and Note Frequency and buffer length
fs = 44100; %Hertz
note = 880; %Hertz
bufferLength = 1000; %Samples

%Print Delay in ms
delayS = (bufferLength/fs);
delayMS = delayS*1000

%Create Square
%Calculate Cycles of note per bufferLength
numCycles = note*delayS;
square = zeros(1, bufferLength);

% Generate repeating Square WaveForm
halfCycleLength = (bufferLength/numCycles)/2;
halfCycleCounter = halfCycleLength;
negativeHalf = 0;
for i = 1 : bufferLength
   
   if i > halfCycleCounter
       halfCycleCounter = halfCycleCounter + halfCycleLength;
       if negativeHalf == 0
           negativeHalf = 1;
       else
           negativeHalf = 0;
       end
   end
    
   if negativeHalf == 0
       square(i) = 1;
   else
       square(i) = -1;
   end
end


%Take FFTs
fftCenter = bufferLength/2 + 1;
FrequencyPerSample = fs/bufferLength;

fftSquare = fftshift(fft(ifftshift(square)));
absFFTSquare = abs(fftSquare);

figure;
plot(square);
figure;
plot(absFFTSquare);

%Find Note Frequency
threshold = 20; %Note must exceed this threshold energy to be registered as note
                %ToDo: Use this value and figure out how to calculate it

maxValue = 0;
maxValueAt = 0;
for i=1 : bufferLength
    if maxValue < absFFTSquare(i)
        maxValueAt = i;
        maxValue = absFFTSquare(i);
    end
end

%Calculate Note
distFromCenter = abs(maxValueAt - fftCenter);
foundNote = distFromCenter*FrequencyPerSample