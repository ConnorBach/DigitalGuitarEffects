% wah function
% band pass filter
% resonant frequency that changes with time
% small bandwidth
% See DAFX: Digital Audio Effects by Udo Zolzer
function y = wah(x, fs)

% Setup input and output vectors
numPts = length(x);
y1 = zeros(1,numPts);
y2 = zeros(1,numPts);
y3 = zeros(1,numPts);

d = 0.06; % damping coefficent
fmin = 200; % min frequency
fmax = 800; % max frequency
wahf = 2200; % wah frequency

df = wahf/fs; % change in frequency

% create triangle waves
triWaves = fmin:df:fmax;
while(length(triWaves) < length(x))
    downSlope = (fmax:-df:fmin);
    triWaves = [ triWaves downSlope ]; % add down slope to wave
    
    upSlope = (fmin:df:fmax);
    triWaves = [triWaves upSlope]; % add up slope to wave
end

% trim wave if it is too big
if(length(triWaves) > length(x))
    triWaves = triWaves(1:length(x));
end

% calculate tuning coefficents
% F = 2sin(pi* triWaves / fs)
% Q = 2d
F = 2*sin(pi* triWaves / fs);
Q = 2*d;

% calculate output y values
y1 = x(1);
y2 = F*y1(1);
y3 = F*y2(1);

% difference equations given by filter
for i=2:numPts
    y1(i) = x(i) - y3(i-1) - Q*y2(i-1);
    y2(i) = F*y1(i) + y2(i-1);
    y3(i) = F*y2(i) + y3(i-1);
    
    % get new tuning coefficents
    F = 2*sin(pi* triWaves(i) / fs);
end

% normalize the curve
finalVal = abs(y2);
y = y2/max(finalVal);