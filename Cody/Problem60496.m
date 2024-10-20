function Problem60496()
    % Generate a point cloud on an equilateral triangle 7
    % https://jp.mathworks.com/matlabcentral/cody/problems/60496
    
    test();
end

function [W,N] = lattice7(H)
    W = (nchoosek(0:3*H+1,2) - [0 1]) * [1 -sqrt(3); 1 sqrt(3)];
    W = W(rem(W(:,1),3)~=1,:) / 3 / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 2/3 0; 2/3 sqrt(4/3); 1 sqrt(3)/3; 1 sqrt(3); 5/3 sqrt(3)/3; 2 0];
    
    [W,N] = lattice7(H);
    assert(isequal(N,7))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    [~,N] = lattice7(H);
    assert(isequal(N,19))
    
    %%
    H = 3;
    [~,N] = lattice7(H);
    assert(isequal(N,37))
    
    %%
    H = 4;
    [~,N] = lattice7(H);
    assert(isequal(N,61))
    
    %%
    H = 5;
    [~,N] = lattice7(H);
    assert(isequal(N,91))
    
    %%
    H = 10;
    [~,N] = lattice7(H);
    assert(isequal(N,331))
    
    %%
    H = 100;
    [~,N] = lattice7(H);
    assert(isequal(N,30301))
end
