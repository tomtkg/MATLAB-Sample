function Problem60446()
    % Generate a point cloud on an equilateral triangle 1
    % https://jp.mathworks.com/matlabcentral/cody/problems/60446
    
    test();
end

function [W,N] = lattice1(H)
    W = (nchoosek(0:H+1,2) - [0 1]) * [1 -sqrt(3); 1 sqrt(3)] / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 1 sqrt(3); 2 0];
    
    [W,N] = lattice1(H);
    assert(isequal(N,3))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    A = [0 0; 0.5 sqrt(3)/2; 1 0; 1 sqrt(3); 1.5 sqrt(3)/2; 2 0];
    
    [W,N] = lattice1(H);
    assert(isequal(N,6))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 3;
    [~,N] = lattice1(H);
    assert(isequal(N,10))
    
    %%
    H = 4;
    [~,N] = lattice1(H);
    assert(isequal(N,15))
    
    %%
    H = 5;
    [~,N] = lattice1(H);
    assert(isequal(N,21))
    
    %%
    H = 10;
    [~,N] = lattice1(H);
    assert(isequal(N,66))
    
    %%
    H = 100;
    [~,N] = lattice1(H);
    assert(isequal(N,5151))
end
