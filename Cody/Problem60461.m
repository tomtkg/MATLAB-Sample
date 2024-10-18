function Problem60461()
    % Generate a point cloud on an equilateral triangle 2
    % https://jp.mathworks.com/matlabcentral/cody/problems/60461
    
    test();
end

function [W,N] = lattice2(H)
    W = [nchoosek(0:H+1,2)-[0 1]; nchoosek(0:H,2)+[1 -1]/3];
    if H > 1
        W = [W; nchoosek(0:H-1,2) + [2 1]/3];
    end
    W = W * [1 -sqrt(3); 1 sqrt(3)] / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 1 sqrt(3)/3; 1 sqrt(3); 2 0];
    
    [W,N] = lattice2(H);
    assert(isequal(N,4))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    A = [0 0; 0.5 sqrt(3)/6; 0.5 sqrt(3)/2; 1 0; 1 sqrt(3)/3;
        1 sqrt(4/3); 1 sqrt(3); 1.5 sqrt(3)/6; 1.5 sqrt(3)/2; 2 0];
    
    [W,N] = lattice2(H);
    assert(isequal(N,10))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 3;
    [~,N] = lattice2(H);
    assert(isequal(N,19))
    
    %%
    H = 4;
    [~,N] = lattice2(H);
    assert(isequal(N,31))
    
    %%
    H = 5;
    [~,N] = lattice2(H);
    assert(isequal(N,46))
    
    %%
    H = 10;
    [~,N] = lattice2(H);
    assert(isequal(N,166))
    
    %%
    H = 100;
    [~,N] = lattice2(H);
    assert(isequal(N,15151))
end
