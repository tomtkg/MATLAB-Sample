function Octagram(f)
    persistent x y 

    if f == 1
        [x,y] = pol2cart(linspace(0, 2*pi, 9) + pi*3/8, 1);
        x = x([1 4 7 2 5 8 3 6 1]);
        y = y([1 4 7 2 5 8 3 6 1]);

        set(gcf, 'Color', 'w');
        xlim([-1 1]);
        ylim([-1 1]);
        hold on
        axis off
        viscircles([0 0], 1, 'Color', 'b');
        plot(x, y, 'Color', [.9 .9 .9], 'LineWidth', 2);
    end

    s = ceil(f / 12);
    a = mod(f-1, 12) + 1;

    x2 = x(s) + (x(s+1) - x(s)) * a / 12;
    y2 = y(s) + (y(s+1) - y(s)) * a / 12;
    plot([x(s) x2], [y(s) y2], 'k-', 'LineWidth', 2);
end
