function g = peak_timing()
    g.init   = @initState;
    g.update = @updateState;
    g.render = @renderFrame;
end

function state = initState(ax)
    x = linspace(0, 2*pi, 1000);
    plot(ax, 400+200*sin(x), 250+200*cos(x), 'k', 'LineWidth', 2);
    plot(ax, 400, 470, 'v', 'MarkerSize', 20, 'MarkerFaceColor', 'r');

    text(ax, 165, 510, 'Click at the top!', 'FontSize', 40);
    state.best  = text(ax, 525, 540, 'Best:  0', 'FontSize', 40);
    state.score = text(ax, 500, 480, 'Score:  0', 'FontSize', 40);
    state.v = 0;
    state.t = 0;
    state.p = plot(ax, 600, 450, 'o', ...
        'MarkerSize', 10, 'MarkerFaceColor', 'r', ...
        'HitTest', 'off', 'PickableParts', 'none');
end

function state = updateState(state, dt, pressed)
    state.t = state.t + 5*dt;
    if pressed
        v = round(50+50*cos(state.t));
        state.score.String = sprintf('Score:%3d', v);
        if state.v < v
            state.v = v;
            state.best.String = sprintf('Best:%3d', v);
        end
    end
end

function renderFrame(~, state)
    state.p.XData = 400+200*sin(state.t);
    state.p.YData = 250+200*cos(state.t);
end
