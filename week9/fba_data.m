% data file for flux balance analysis in systems biology
% From Segre, Zucker et al "From annotated genomes to metabolic flux
% models and kinetic parameter fitting" OMICS 7 (3), 301-316. 

% Stoichiometric matrix
S = [
%	M1	M2	M3	M4	M5	M6	
	1	0	0	0	0	0	%	R1:  extracellular -->  M1
	-1	1	0	0	0	0	%	R2:  M1 -->  M2
	-1	0	1	0	0	0	%	R3:  M1 -->  M3
	0	-1	0	2	-1	0	%	R4:  M2 + M5 --> 2 M4
	0	0	0	0	1	0	%	R5:  extracellular -->  M5
	0	-2	1	0	0	1	%	R6:  2 M2 -->  M3 + M6
	0	0	-1	1	0	0	%	R7:  M3 -->  M4
	0	0	0	0	0	-1	%	R8:  M6 --> extracellular
	0	0	0	-1	0	0	%	R9:  M4 --> cell biomass
	]';

[m,n] = size(S);
vmax = [
	10.10;	% R1:  extracellular -->  M1
	100;	% R2:  M1 -->  M2
	5.90;	% R3:  M1 -->  M3
	100;	% R4:  M2 + M5 --> 2 M4
	3.70;	% R5:  extracellular -->  M5
	100;	% R6:  2 M2 --> M3 + M6
	100;	% R7:  M3 -->  M4
	100;	% R8:  M6 -->  extracellular
	100;	% R9:  M4 -->  cell biomass
	];

%original problem
    cvx_clear
    cvx_begin 
        variable v(9)
        dual variables l1 l2 l3
        maximize(v(9))
        subject to 
        S*v == 0 :l1
        v>=0 : l2
        v<=vmax : l3
    cvx_end

    
spd_perturb = zeros(9,1)


for i = 1:9
    vmaxp = vmax;
    vmaxp(i)=vmaxp(i)*0.8;
    cvx_clear
    cvx_begin quiet
        variable v(9)
        maximize(v(9))
        subject to 
        S*v == 0
        v>=0
        v<=vmaxp
    cvx_end
    spd_perturb(i) = cvx_optval;
end

    
    
spd = zeros(9,1);
for i = 1:9
    vmaxp = vmax;
    vmaxp(i) = 0;
    cvx_clear
    cvx_begin quiet
        variable v(9)
        maximize(v(9))
        subject to 
        S*v == 0
        v>=0
        v<=vmaxp
    cvx_end
    spd(i) = cvx_optval;
end

spd_pairs = ones(9,9)*13
for i = 2:8
    for j=i+1:8
        [i j]
        vmaxp = vmax;
        vmaxp(i)=0;
        vmaxp(j)=0;
        cvx_clear
        cvx_begin quiet
            variable v(9)
            maximize(v(9))
            subject to 
            S*v == 0
            v>=0
            v<=vmaxp
        cvx_end
        spd_pairs(i,j) = cvx_optval;
    end
end
essential_genes = find(spd<=13.55 *0.2)
[lethalX,lethalY] = find(spd_pairs<=13.55*0.2)




