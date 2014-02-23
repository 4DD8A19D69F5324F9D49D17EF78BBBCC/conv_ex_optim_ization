n = 100
% scale c to make obj significant
c = rand(n,1)*1000;
A = rand(n,n)-10;
b = ones(n,1)*-100;


cvx_begin
    variable x(n)
    dual variables u v w
    minimize(c'*x)
    subject to
    u: A*x <= b
    v: x>=0
    w: x<=1
cvx_end

b'*u - max(0,sum(w))
- (b'*u)^2 - max(0,sum(w))
-b'*u - sum(w)

cvx_begin
    variable miu(n)
    maximize(-b'*miu + sum(min(0,A'*miu+c)));
    miu>=0;
cvx_end

cvx_begin
    variable miu(n)
    maximize(-square(b'*miu) - sum(max(0,A'*miu+c)));
    miu>=0;
cvx_end