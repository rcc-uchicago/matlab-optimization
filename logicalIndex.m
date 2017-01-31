function logicalIndex
%% Logical Indexing 
% Copyright 2015 The MathWorks, Inc.
%
% This is an example of how to do some logical indexing -- 
% how you can vectorize code that might use an nested for loop
% and an if statement. 

%%  Finding elements using logical matrices
% " While most indices are numeric, indicating a certain row or column
% number, logical indices are positional. That is, it is the position of 
% each 1 in the logical matrix that determines which array element is 
% being referred to " 

N = 4000;

A  = magic(N);
A2 = magic(N);
A3 = magic(N);

thresh = 1e6;

%%  Using an if and a nested for loop 
%  In this example we want to find all values that are over myRef.
%  This is how we do that in a nested for loop with an if-statement:
display('Using a nested loop')
tic

ix = 1;

vals = zeros(numel(A),1);

for jj = 1:N
    for ii = 1:N
        if A(ii,jj) > thresh
            vals(ix) = A(ii,jj);
            ix = ix + 1;
        end
    end
end

vals(ix:end) = [];

toc

%%  Using the find Function

% "The find function determines the indices of array elements that meet 
% a given logical condition. It returns the indices in the form of linear
% indexing " !

% myIndex = find(A2 > thresh);
% display(myIndex(1:3))

%%
display('Using the find function')
tic
vals2 = A2(find(A2 > thresh));
toc


%% Using logical indexing

display('Using logical indexing')
tic
vals3 = A3(A3 > thresh);
toc


%% Assert same answer
assert(isequal(vals,vals2,vals3),'vals aren''t equal');
% Copyright 2015 The MathWorks, Inc.
