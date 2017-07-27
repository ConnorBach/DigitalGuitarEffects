% flanger function
% FIR delay with oscillating delay time
function y = flanger(x,fs)

delay = .005; % delay in ms
flangeRate = 2; % flanger rate Hz

numPts = 1:length(x); % length array

% setup output array
y = zeros(1,length(x));
y(1:round(delay*fs)) = x(1:round(delay*fs));

oscDelay = sin(2*pi*numPts*(flangeRate/fs))'; % oscillating delay

% apply filter delay
c = .8; % coefficient
for i=(round(delay*fs)+1):length(x)
    % current signal + signal with delay
    y(i) = c*x(i) + c*x(i-ceil(abs(oscDelay(i))*round(delay*fs)));
end