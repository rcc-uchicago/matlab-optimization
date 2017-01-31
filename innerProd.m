% A function to calculate inner product of two vectors using a loop
% This is for illustration purpose. Please use the dot function instead
% for a real world application.

function s=innerProd()
count=10000;
limit=100;
x=linspace(1,limit,count);
y=linspace(1,limit,count);
tic;
for i=1:10000
    s=inner(x,y);
end
toc
end

function s = inner(x,y)
    s=0;
    for i=1:length(x)
       s=x(i)*y(i)+s;
    end    
end


