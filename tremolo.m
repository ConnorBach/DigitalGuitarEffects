% Tremolo function
% Amplitude modulation
function y = tremolo(x,fs)
numPts = 1:length(x);
modFreq = 15; % modulation frequency (must be less than 20 Hz)
y = x.*(1 + .5 * sin(2*pi*numPts*(modFreq/fs))');