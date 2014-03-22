rand('state',0);
n=10;m=20;
edges=[[1 1 1 2 2 2 3 3 4 4 5 5 6 6 7 7 8 7 8 9]'...
    [2 3 4 6 3 4 5 6 6 7 8 7 7 8 8 9 9 10 10 10]'];
A=zeros(n,m);
for j=1:size(edges,1)
    A(edges(j,1),j)=-1;A(edges(j,2),j)=1;
end
a=2*rand(m,1);
x_max = 1+rand(m,1);B=m/2;

% code to plot the graph (if you have biograph)
G=sparse(edges(:,1),edges(:,2),1,n,n);
%view(biograph(G));

cvx_begin
    variable x(m);
    expression p(n);
    logprob = -a.*x;
    p(1)=0;
    for i = 2:m
        p(i) = -1e5;
    end
    for i = 1:m
        p(edges(i,2)) = max(p(edges(i,2)), p(edges(i,1)) + logprob(i));
    end
    minimize(p(n))
    sum(x)<=B;
    x>=0
    x<=x_max
cvx_end

exp(p(n))


x = B / m * ones(m,1);
logprob = -a.*x;
    p(1)=0;
    for i = 2:m
        p(i) = -1e5;
    end
    for i = 1:m
        p(edges(i,2)) = max(p(edges(i,2)), p(edges(i,1)) + logprob(i));
    end
    
exp(p(10))
