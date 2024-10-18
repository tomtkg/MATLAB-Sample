function Problem60466()
    % Generate a point cloud on an equilateral triangle 3
    % https://jp.mathworks.com/matlabcentral/cody/problems/60466
    
    test();
end

function [W,N] = lattice3(H)
    W = [nchoosek(0:H+1,2)-[0 1]; nchoosek(0:H,2)+[1 -1]/3];
    W = W * [1 -sqrt(3); 1 sqrt(3)] / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 1 sqrt(3)/3; 1 sqrt(3); 2 0];
    
    [W,N] = lattice3(H);
    assert(isequal(N,4))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    A = [0 0; 0.5 sqrt(3)/6; 0.5 sqrt(3)/2; 1 0;1 sqrt(4/3);
        1 sqrt(3); 1.5 sqrt(3)/6; 1.5 sqrt(3)/2; 2 0];
    
    [W,N] = lattice3(H);
    assert(isequal(N,9))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 3;
    [~,N] = lattice3(H);
    assert(isequal(N,16))
    
    %%
    H = 4;
    [~,N] = lattice3(H);
    assert(isequal(N,25))
    
    %%
    H = 5;
    [~,N] = lattice3(H);
    assert(isequal(N,36))
    
    %%
    H = 10;
    [~,N] = lattice3(H);
    assert(isequal(N,121))
    
    %%
    H = 100;
    [~,N] = lattice3(H);
    assert(isequal(N,10201))
end
