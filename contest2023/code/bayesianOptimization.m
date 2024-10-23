function bayesianOptimization(ff)
    last = ceil(ff/8);
    
    f = @(x) sin(0.03*pi*x) + 0.01*x;
    X = (0:100)';
    x = [10;100];
    I = 30;
    
    for i = 0 : last
        x = [x;I];
        y = f(x);
        model = fitrgp(x,y);
        [Yhat,~,Yint] = predict(model,X);
        [~,I] = max(Yint(:,2));
        
        if i == last
            cla
            xline(x(end));
            hold on
            fill([X; flip(X)],[Yint(:,1); flip(Yint(:,2))], ...
                [.8 .8 .8],'edgecolor','none');
            plot(X,Yhat,'k');
            plot(x,y,'or','Markerfacecolor','w');
            hold off
            box on
            ylim([-0.5 2.5]);
        end
    end
end
