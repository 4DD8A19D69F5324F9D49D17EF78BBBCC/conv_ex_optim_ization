n = 100;
r = -30:100/(n-1):70;
miu = [8 20];
sigma = [6 17.5];
pho = -0.25;

P = zeros(2,n);



for k = 1:2
    for i = 1:n
        P(k,i) = exp( -(r(i)-miu(k))^2 / (2*sigma(k)^2));
    end
end

P(1,:) = P(1,:)/sum(P(1,:));
P(2,:) = P(2,:)/sum(P(2,:));


M = zeros(n,n);
for i = 1:n
    for j = 1:n
        M(i,j) = (r(i) - miu(1))* (r(j) - miu(2));
    end
end

D = zeros(n,n);

for i = 1:n
    for j = 1:n
        D(i,j) = (r(i) + r(j))<=0;
    end
end


cvx_clear
cvx_begin
cvx_solver sdpt3
    variable p(n,n)
    maximize(sum(sum(D.*p)))
    subject to
    sum(p,1) == P(2,:);
    sum(p,2) == P(1,:)';
   sum(sum(p))==1
   sum(sum(M.* p)) == pho *sigma(1) *sigma(2)
    p>=0;
cvx_end

mesh(p)




    