[x val l1 l2 l3] = w4p1(-2,-3);
disp('x=');
disp(x)
disp('l3=')
disp(l3);
rg = [ 0 -0.1 0.1];

for i = rg
    for j = rg
        [x2, pexact,lp1 ,lp2,lp3] = w4p1(-2+i,-3+j);
        ppred = val - [i j]*[l1 l2]';
        tgap = pexact - ppred;
        disp([i j ppred pexact tgap])
    end
end



x = 1:8;
y = arrayfun((@(u)w4p2(u)),x)
y = arrayfun( @(x) x*x+1,y)
plot(x,y)
