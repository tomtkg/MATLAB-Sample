function Problem59581()
    % Generate a point cloud named `Incremental Lattice Design`
    % https://jp.mathworks.com/matlabcentral/cody/problems/59581
    
    test();
end

function [W,N] = ILD(M,H)
    I = M * eye(M);
    W = zeros(1,M);
    edgeW = W;
    for i = 1 : H
        edgeW = repmat(edgeW,M,1) + repelem(I,size(edgeW,1),1);
        edgeW = unique(edgeW,'rows');
        edgeW(all(edgeW,2),:) = [];
        W = [W+1;edgeW];
    end
    W = W / (M*H);
    N = size(W,1);
end

function test()
    %%
    M = 3; H = 1;
    A = [0 0 1; 0 1 0; 1/3 1/3 1/3; 1 0 0];
    
    [W,N] = ILD(M,H);
    assert(isequal(N,4))
    assert(sum(abs(sortrows(W)-A),'all') < 1e-6)
    
    %%
    M = 4; H = 2;
    A = [0 0 0 1; 0 0 1/2 1/2; 0 0 1 0; 0 1/2 0 1/2; 0 1/2 1/2 0;
        0 1 0 0; 1/8 1/8 1/8 5/8; 1/8 1/8 5/8 1/8; 1/8 5/8 1/8 1/8; 1/4 1/4 1/4 1/4;
        1/2 0 0 1/2; 1/2 0 1/2 0; 1/2 1/2 0 0; 5/8 1/8 1/8 1/8; 1 0 0 0];
    
    [W,N] = ILD(M,H);
    assert(isequal(N,15))
    assert(sum(abs(sortrows(W)-A),'all') < 1e-6)
    
    %%
    M = 3; H = 9;
    [~,N] = ILD(M,H);
    assert(isequal(N,136))
    
    %%
    M = 4; H = 8;
    [~,N] = ILD(M,H);
    assert(isequal(N,425))
    
    %%
    M = 5; H = 5;
    [~,N] = ILD(M,H);
    assert(isequal(N,251))
    
    %%
    M = 8; H = 8;
    [~,N] = ILD(M,H);
    assert(isequal(N,12869))
end
