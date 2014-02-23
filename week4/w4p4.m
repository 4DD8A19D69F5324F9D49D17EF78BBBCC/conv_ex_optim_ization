V = [];
F = 0.9;
C = 1.15;
S0 = 1.0;

%construct V matrix
for S = 0.5:1.5/199:2
    payoff = 0.0;
    if S>C
        payoff = C-S0;
    elseif  F<=S && S<=C
        payoff = S-S0;
    else
        payoff = F-S0;
    end
    V = [V; 1.05 S max(0,S-1.1) max(0,S-1.2) max(0,0.8-S) max(0,0.7-S) payoff];
end

P = [1 1 0.06 0.03 0.02 0.01 0]';

cvx_clear
cvx_begin
    variable p
    variables y(200)
    maximize(p)
    subject to
    V'*y  == P + [zeros(6,1);p]
    y>=0
cvx_end
    
