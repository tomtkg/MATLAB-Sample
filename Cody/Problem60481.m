function Problem60481()
    % Generate a point cloud on an equilateral triangle 5
    % https://jp.mathworks.com/matlabcentral/cody/problems/60481
    
    test();
end

function [W,N] = lattice5(H)
    P = [0 -3; 1 -1; 2 1];
    W = [];
    for i = 1 : min(3,H)
        W = [W; nchoosek(0:H+1-i,2)+P(i,:)/3];
    end
    W = setdiff(nchoosek(0:3*H+1,2)-[0 1],W*3+[1 2],"rows") * [1 -sqrt(3); 1 sqrt(3)] / 3 / H;
    N = size(W,1);
end

function test()
    %%
    H = 1;
    A = [0 0; 1/3 sqrt(3)/3; 2/3 0; 2/3 sqrt(4/3);
        1 sqrt(3); 4/3 0; 4/3 sqrt(4/3); 5/3 sqrt(3)/3; 2 0];
    
    [W,N] = lattice5(H);
    assert(isequal(N,9))
    assert(sum(abs(sortrows(W)-sortrows(A)),'all') < 1e-6)
    
    %%
    H = 2;
    [~,N] = lattice5(H);
    assert(isequal(N,24))
    
    %%
    H = 3;
    [~,N] = lattice5(H);
    assert(isequal(N,45))
    
    %%
    H = 4;
    [~,N] = lattice5(H);
    assert(isequal(N,72))
    
    %%
    H = 5;
    [~,N] = lattice5(H);
    assert(isequal(N,105))
    
    %%
    H = 10;
    [~,N] = lattice5(H);
    assert(isequal(N,360))
    
    %%
    H = 100;
    [~,N] = lattice5(H);
    assert(isequal(N,30600))
end
