%Create Sine
numCycles = 5;
t = numCycles*2*pi/100:numCycles*2*pi/100:numCycles*2*pi;
sineTDomain = cos(t);

%Create Repeating Square Wave
x = zeros(1,100);

%Note that we need zero crossings to get our frequency displayed how
%we would like it.
x(1:9) = -1;
x(21:29) = -1;
x(41:49) = -1;
x(61:69) = -1;
x(81:89) = -1;

x(10:20) = 1;
x(30:40) = 1;
x(50:60) = 1;
x(70:80) = 1;
x(90:100) = 1;

%Sine and Square Superposition
xPlusSine = x+sineTDomain;

%Take FFTs
fftx = fftshift(fft(ifftshift(x)));
fftSine = fftshift(fft(ifftshift(sineTDomain)));
fftxPlusSine = fftshift(fft(ifftshift(xPlusSine)));