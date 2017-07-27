% Distortion function
% Uses f(x) = sgn(x) * (1 - e^(-abs(x)))
% See DAFX: Digital Audio Effects by Udo Zolzer
function y = distortion(x, gain)
y = sign(gain.*x) .* (1 - exp(-1.*abs(gain.*x)));