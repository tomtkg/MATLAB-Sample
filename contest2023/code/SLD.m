function SLD(f)
    H = ceil(f/3); % Decomposition parameter
    M = 3;         % Number of dimensions
    
    W = nchoosek(1:H+M-1,M-1) - repmat(0:M-2,nchoosek(H+M-1,M-1),1) - 1;
    W = ([W,zeros(size(W,1),1)+H]-[zeros(size(W,1),1),W])/H;
    
    plot3(W(:,1),W(:,2),W(:,3),'o','MarkerSize',8, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    view(135,30);
    box on
    
    %--------------------------------- Reference ----------------------------------
    % [1] H. Scheffé, "Experiments with mixtures," Journal of the RoyalStatistical
    % Society: Series B (Methodological), Vol. 20, No. 2, pp. 344–360, 1958.
    % [2] I. Das and J. E. Dennis, "Normal-boundary intersection: A new method for
    % generating the Pareto surface in nonlinear multicriteria optimization
    % problems," SIAM Journal on Optimization, Vol. 8, No. 3, pp. 631–657, 1998.
    %------------------------------------------------------------------------------
end
