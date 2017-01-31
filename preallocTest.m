% A function to test the effect of pre-allocating memory in MATLAB

function preallocTest()
N = 2000;
tic
for i=1:N
    for j=1:N
        A(i,j) = i;
    end
end
without = toc

tic 
B = zeros(N,N);
for i = 1:N
    for j=1:N
        B(i,j) = i;
    end
end

with = toc

ratio = without / with

end
