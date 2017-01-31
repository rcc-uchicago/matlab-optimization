% A function demonstrating the difference between loop-based operation
% and the built-in vector-based function

function logTest()

A = rand(200);

logA = zeros(size(A));

tic

for i = 1:size(A,1)
    for j = 1:size(A,2)
        logA(i,j) = log(A(i,j));
    end
end

novec = toc

tic 

logA2 = log(A);

vec = toc

ratio = novec/vec

end
