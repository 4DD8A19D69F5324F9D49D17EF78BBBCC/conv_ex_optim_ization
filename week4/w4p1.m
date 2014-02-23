function [ x,val,l1,l2,l3] = w4p1( u1,u2 )
%W4P1 Summary of this function goes here
%   Detailed explanation goes here
    cvx_clear
    cvx_begin quiet
        variable x(2);
        dual variables l1 l2 l3; 
        minimize(quad_form(x,[1 -1;0 2]) - [1 0]*x);
        subject to
        l1 : [1 2]*x <= u1;
        l2 : [1 -4]*x <= u2; 
        l3 : [1 1]*x >=-5;
    cvx_end
    val = cvx_optval;
end

