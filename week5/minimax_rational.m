t = -3:6/200:3;
y = exp(t);

cvx_clear

left = -1e5
right = 1e5


while right - left > 1e-5
    T = (left + right)/2.0
    cvx_begin quiet
        minimize(0)
        variables a0 a1 a2 b1 b2
        subject to
            a0 * ones(1,length(t)) + a1*t + a2 * t.^2  - y.*(ones(1,length(t)) + b1*t + b2 *t.^2) <= T *(1 + b1*t + b2 *t.^2)
            a0 * ones(1,length(t)) + a1*t + a2 * t.^2  - y.*(ones(1,length(t)) + b1*t + b2 *t.^2) >= -T * (1 + b1*t + b2 *t.^2) 
            ones(1,length(t)) + b1*t + b2 *t.^2 >= zeros(1,length(t))
    cvx_end
    if strcmp(cvx_status,'Solved')
        right = T;
    else
        left = T;
    end
end

