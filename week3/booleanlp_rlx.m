rng(0,'v5uniform');
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);
cvx_begin quiet
    variable x(n)
    minimize(c'*x)
    A*x<=b
    0<=x<=1
cvx_end

ts = 0:0.001:1;
vio=arrayfun(@(t)max(A*(x>=t)-b) ,ts);
obj=arrayfun(@(t) c'*(x>=t),ts);
plot(ts,obj,ts,vio);
U = min(obj(find(vio<=0)));
L = cvx_optval
U-L