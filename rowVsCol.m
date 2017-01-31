function rowVsCol
%% Comparing indexing by row vs by column
% Copyright 2015 The MathWorks, Inc.
% Based on example by S. McGarrity

%% Initializing variables

N = 3000;
thresh = 0.5;

x1 = rand(N);
x2 = rand(N);
y1 = zeros(N);
y2 = zeros(N);

%% Using Row Major Indexing
display('Using Row Major Indexing')

tic

for r = 1:N % Row
    for c = 1:N % Column
        if x1(r,c) > thresh
            y1(r,c) = x1(r,c);
        end
    end
end

toc

%% Using Column Major Indexing

display('Using Column Major Indexing')

tic

for c = 1:N % Column
    for r = 1:N % Row
        if x2(r,c) > thresh
            y2(r,c) = x2(r,c);
        end
    end
end

toc
