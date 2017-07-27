% reverb function
% Uses Schroeder's algorithm
% N allpass filters
function y = reverb(x, numFilters, gain, gain2, delay)

% first filter
c2=[gain zeros(1,delay(1)-1) 1];
c1=[1 zeros(1,delay(1)-1) gain];
y=filter(c2,c1,x);

% apply rest of filters
for i=2:numFilters
    
    c4=[gain zeros(1,delay(i)-1) 1];
    c3=[1 zeros(1,delay(i)-1) gain];

    %filter the input signal 
    y=filter(c4,c3,x);
    
    c1 = conv(c1, c3);
    c2 = conv(c2, c4);
end

% normalize signal
y = (y+gain2*x)/max(y);