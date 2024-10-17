function Octagram2(f)
    persistent p
    
    x = [2 1 3 1 2 3 1 3 2];
    y = [3 1 2 3 1 3 2 1 3];

    if f == 1
        set(gcf, 'Color', 'w');
        xlim([1 3]);
        ylim([1 3]);
        hold on
        axis off
        colormap(hsv);
        clim([0 96]);
        patch(x, y, 0:12:96, 'LineWidth', 2, ...
            'FaceColor', 'none', 'EdgeColor', 'interp');
        p = patch();
    end

    s = ceil(f / 12);
    a = mod(f-1, 12);

    x2 = x(s) + (x(s+1) - x(s)) * a / 12;
    y2 = y(s) + (y(s+1) - y(s)) * a / 12;

    p.delete
    p = patch(x2, y2, f-1, 'Marker', 'o', 'MarkerSize', 10, ...
        'MarkerFaceColor', 'flat', 'EdgeColor', 'interp');
end
