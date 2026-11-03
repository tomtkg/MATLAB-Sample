function g = mash_it()
    g.init   = @initState;
    g.update = @updateState;
    g.render = @renderFrame;
end

function state = initState(ax)
    state.mode  = 1;
    state.count = 0;
    state.time  = tic;
    state.timer = text(ax, 640, 560, '9.99', 'FontSize', 80);
    state.text  = text(ax, 400, 300, {'Click as fast' 'as you can!'}, ...
        'HorizontalAlignment', 'center', 'FontSize', 100);
end

function state = updateState(state, ~, pressed)
    t = toc(state.time);
    if t < 3
        return;
    end
    state.count = state.count + pressed;
    if state.mode == 2
        pressed = t >= 13;
    end
    if pressed
        state.mode = rem(state.mode, 3) + 1;
        state.count = 0;
        state.time = tic;
    end
end

function renderFrame(~, state)
    switch state.mode
        case 1
            state.timer.String = '9.99';
            state.text.String = {'Click as fast' 'as you can!'};
        case 2
            t = rem(13 - toc(state.time), 10);
            state.timer.String = sprintf('%.2f', t);
            state.text.String = sprintf('%d', state.count);
        case 3
            state.timer.String = '0.00';
    end
end
