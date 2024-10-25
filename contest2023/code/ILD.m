function ILD(f)
    H = ceil(f/4); % Decomposition parameter
    M = 3;         % Number of dimensions
    
    I = M * eye(M);
    W = zeros(1,M);
    edgeW = W;
    for i = 1 : H
        edgeW = repmat(edgeW,M,1) + repelem(I,height(edgeW),1);
        edgeW = unique(edgeW,'rows');
        edgeW(all(edgeW,2),:) = [];
        W = [W+1;edgeW];
    end
    W = W / (M*H);
    
    plot3(W(:,1),W(:,2),W(:,3),'o','MarkerSize',8, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    view(135,30);
    box on
    
    %--------------------------------- Reference ----------------------------------
    % T. Takagi, K. Takadama, and H. Sato, Incremental lattice design of weight 
    % vector set, Proceedings of the Genetic and Evolutionary Computation 
    % Conference Companion, 2020, 1486-1494.
    %------------------------------------------------------------------------------
end
