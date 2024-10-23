function emerging46_2(f)
    persistent x y c txt
    nFrames = 48; vertex = 8;
    
    if f == 1
        a = nFrames * vertex;
        [x,y] = pol2cart(2*pi*(1:a)/a, 1);
        x = reshape(x, [], vertex);
        y = reshape(y, [], vertex);
        c = pdist([x(1,:)' y(1,:)']);

        set(gcf, 'Color', 'k');
        axes(Position = [-0.14 -0.14 1.28 1.28]);
        colormap(jet(vertex));
        clim([0.8 2.5])
        txt = text();
        hold on
        axis off
    end
    
    G = graph(ones(vertex), 'omitselfloops');
    plot(G, 'XData', x(f,:), 'YData', y(f,:), 'Marker', 'none', ...
        'NodeLabel', {}, EdgeCData = c, EdgeAlpha = 0.3);

    txt.delete
    txt = text(0, 0, '46', HorizontalAlignment = 'Center', ...
        FontUnits = 'normalized', FontSize = 0.2, Color = 'k');
end
