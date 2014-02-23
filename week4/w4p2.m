function [ x,cvx_optval,l ] = w4p2( u )
    cvx_clear
    cvx_begin quiet
        variable x;
        dual variable l;
        minimize(x*x+1);
        subject to
            l: x*x-6*x+8<=u;
    cvx_end
end

