function g = one_shape_jumper()
    g.init   = @initState;
    g.update = @updateState;
    g.render = @renderFrame;
end

function state = initState(ax)
    % The harness already gave us an 800x600 world and hold on.
    % We just want a screen-y-down orientation and a dark background.
    ax.YDir  = 'reverse';
    ax.Color = [0.10 0.12 0.18];

    state.y        = 300;
    state.velocity = 0;
    state.gravity  = 900;
    state.jump     = -320;

    state.player = rectangle(ax, ...
        'Position', [200 state.y 30 30], ...
        'FaceColor', [1 0.8 0.2], 'EdgeColor', 'none', ...
        'HitTest', 'off', 'PickableParts', 'none');
end

function state = updateState(state, dt, pressed)
    if pressed
        state.velocity = state.jump;
    end
    state.velocity = state.velocity + state.gravity * dt;
    state.y        = state.y        + state.velocity * dt;
end

function renderFrame(~, state)
    state.player.Position = [200 state.y 30 30];
end
