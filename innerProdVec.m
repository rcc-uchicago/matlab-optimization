% A function to compare the time between vectorized and non-vectorized 
% calculation of the inner product

function s=innerProdVec()
count=10000;
limit=100;
x=linspace(1,limit,count);
y=linspace(1,limit,count);
tic;
for i=1:1000
    s=inner(x,y);
end
nvec = toc

tic
for i=1:1000
    s=vinner(x,y);
end

vec = toc

ratio = nvec /vec

end

function s = inner(x,y)
    s=0;
    for i=1:length(x)
       s=x(i)*y(i)+s;
    end    
end

function s = vinner(x,y)
    s=sum(x.*y);
end

