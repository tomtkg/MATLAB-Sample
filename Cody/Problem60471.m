function Problem60471()
    % Generate a point cloud on an equilateral triangle 4
    % https://jp.mathworks.com/matlabcentral/cody/problems/60471
    
    test();
end

function [W,N] = lattice4(H)
    W1 = (nchoosek(0:3*H+1,2)-[0 1]);
    W2 = [nchoosek(0:H+1,2)-[0 1]; nchoosek(0:H,2)+[1 -1]/3];
    if H > 1
        W2 = [W2; nchoosek(0:H-1,2) + [2 1]/3];
    end
    W = setdiff(W1,W2*3,"rows") * [1 -sqrt(3); 1 sqrt(3)] / 3 / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [1/3 sqrt(3)/3; 2/3 0; 2/3 sqrt(4/3); 4/3 0; 4/3 sqrt(4/3); 5/3 sqrt(3)/3];
    
    [W,N] = lattice4(H);
    assert(isequal(N,6))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    [~,N] = lattice4(H);
    assert(isequal(N,18))
    
    %%
    H = 3;
    [~,N] = lattice4(H);
    assert(isequal(N,36))
    
    %%
    H = 4;
    [~,N] = lattice4(H);
    assert(isequal(N,60))
    
    %%
    H = 5;
    [~,N] = lattice4(H);
    assert(isequal(N,90))
    
    %%
    H = 10;
    [~,N] = lattice4(H);
    assert(isequal(N,330))
    
    %%
    H = 100;
    [~,N] = lattice4(H);
    assert(isequal(N,30300))
end
