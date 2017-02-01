function str = elapsedTimeDisplay(dur)
% Creates elapsed time string in the format of hr/min/s
%
% Copyright 2015 The MathWorks, Inc.
%
% Example:
%  elapsedTimeDisplay(12345)
%     ans =
%     3 hr 25 min 45.0 s

if dur >= 3600
    str = sprintf('%d hr %d min %0.1f s', floor(dur/3600), ...
        floor(mod(dur, 3600)/60), mod(dur, 60));
elseif dur >= 60
    str = sprintf('%d min %0.1f s', floor(dur/60), mod(dur, 60));
else
    str = sprintf('%0.1f s', dur);
end