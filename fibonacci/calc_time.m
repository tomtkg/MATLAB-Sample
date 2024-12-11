function t = calc_time(f, x, N)
    times = zeros(1, N);
    for i = 1 : N
        tic
        f(x);
        times(i) = toc;
    end
    t = median(times);
end
