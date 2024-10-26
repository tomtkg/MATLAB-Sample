function main()
    addpath('code');
    contestAnimator('test.gif', @test); close;
    contestAnimator('Bayesian Optimization.gif', @bayesianOptimization); close;
    contestAnimator('Incremental Lattice Design.gif', @ILD); close;
    contestAnimator('Simplex-lattice design.gif', @SLD); close;
    contestAnimator('emerging46_1.gif', @emerging46_1); close;
    contestAnimator('emerging46_2.gif', @emerging46_2); close;
end
