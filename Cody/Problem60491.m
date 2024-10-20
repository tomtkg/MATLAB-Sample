function Problem60491()
    % Generate a point cloud on an equilateral triangle 6
    % https://jp.mathworks.com/matlabcentral/cody/problems/60491
    
    test();
end

function [W,N] = lattice6(H)
    W = (nchoosek(0:H+3,2) - [0 1]) * [1 -sqrt(3); 1 sqrt(3)];
    W = W(rem(W(:,1),3)~=1,:) / (H+2);
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 2/3 0; 2/3 sqrt(4/3); 1 sqrt(3)/3; 1 sqrt(3); 5/3 sqrt(3)/3; 2 0];
    
    [W,N] = lattice6(H);
    assert(isequal(N,7))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    A = [0 0; 1/2 0; 1/2 sqrt(3)/2; 3/4 sqrt(3)/4; 3/4 sqrt(3)*3/4;
        5/4 sqrt(3)/4; 5/4 sqrt(3)*3/4; 3/2 0; 3/2 sqrt(3)/2; 2 0];
    
    [W,N] = lattice6(H);
    assert(isequal(N,10))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 3;
    [~,N] = lattice6(H);
    assert(isequal(N,14))
    
    %%
    H = 4;
    [~,N] = lattice6(H);
    assert(isequal(N,19))
    
    %%
    H = 5;
    [~,N] = lattice6(H);
    assert(isequal(N,24))
    
    %%
    H = 10;
    [~,N] = lattice6(H);
    assert(isequal(N,61))
    
    %%
    H = 100;
    [~,N] = lattice6(H);
    assert(isequal(N,3571))
end
