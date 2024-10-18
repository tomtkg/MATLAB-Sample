function Problem60441()
    % Generate a point cloud named `Simplex-Lattice Design`
    % https://jp.mathworks.com/matlabcentral/cody/problems/60441
    
    test();
end

function [W,N] = SLD(M,H)
    N = nchoosek(H+M-1,M-1);
    W = nchoosek(1:H+M-1,M-1) - repmat(0:M-2,N,1) - 1;
    W = ([W,zeros(N,1)+H]-[zeros(N,1),W])/H;
end

function test()
    %%
    M = 3; H = 2;
    A = [0 0 1; 0 .5 .5; 0 1 0; .5 0 .5; .5 .5 0; 1 0 0];
    
    [W,N] = SLD(M,H);
    assert(isequal(N,6))
    assert(sum(abs(sortrows(W)-A),'all') < 1e-6)
    
    %%
    M = 5; H = 2;
    A = [0 0 0 0 1; 0 0 0 .5 .5; 0 0 0 1 0; 0 0 .5 0 .5; 0 0 .5 .5 0;
        0 0 1 0 0; 0 .5 0 0 .5; 0 .5 0 .5 0; 0 .5 .5 0 0; 0 1 0 0 0;
        .5 0 0 0 .5; .5 0 0 .5 0; .5 0 .5 0 0; .5 .5 0 0 0; 1 0 0 0 0];
    
    [W,N] = SLD(M,H);
    assert(isequal(N,15))
    assert(sum(abs(sortrows(W)-A),'all') < 1e-6)
    
    %%
    M = 3; H = 9;
    [~,N] = SLD(M,H);
    assert(isequal(N,55))
    
    %%
    M = 4; H = 8;
    [~,N] = SLD(M,H);
    assert(isequal(N,165))
    
    %%
    M = 5; H = 5;
    [~,N] = SLD(M,H);
    assert(isequal(N,126))
    
    %%
    M = 8; H = 8;
    [~,N] = SLD(M,H);
    assert(isequal(N,6435))
end
