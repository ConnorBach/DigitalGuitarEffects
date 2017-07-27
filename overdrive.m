% Overdrive function
% Uses Schetzen formula to apply soft clipping
% See DAFX: Digital Audio Effects by Udo Zolzer
function y = overdrive(x)

% Setup input and output vectors
numPts = length(x);
y = zeros(1,numPts);

%symetrical soft clipping threshold with Schetzen formula
%           2x                  0 <= x <= 1/3
%
%
% f(x) = {  (3-(2-3x)^2)/3      1/3 <= x <= 2/3
%
%
%           1                   2/3 <= x <= 1
clipThreshold = 1/3;

% apply soft clipping to all points
for i=1:numPts
    
    curPoint = abs(x(i));
    
    % amplify points below threshold
    if(curPoint < clipThreshold)
        y(i) = 2*x(i);
    end
    
    % Schetzen formula for soft clipping
    if curPoint >= clipThreshold
        if x(i) > 0
            y(i) = (3-(2-3*x(i)).^2)/3;
        end
        
        if x(i) < 0
            y(i) = -1 * (3-(2-3*abs(x(i))).^2)/3;
        end
    end
    
    % Set clipping values to 1
    if curPoint > 2*clipThreshold
        if x(i) > 0
            y(i) = 1;
        end
        
        if x(i) < 0
            y(i) = -1;
        end
    end
end