function g = stop_the_clock_challenge()
    g.init   = @initState;
    g.update = @updateState;
    g.render = @renderFrame;
end

function state = initState(ax)
    state.mode = 1;
    state.time = tic;
    state.text = text(ax, 400, 300, {'Hit SPACE or' 'click to start'}, ...
        'HorizontalAlignment', 'center', 'FontSize', 100);
end

function state = updateState(state, ~, pressed)
    switch state.mode
        case 1
            state.text.String = {'Hit SPACE or' 'click to start'};
            state.time = tic;
        case 2
            state.text.String = sprintf('%.2f', toc(state.time));
    end
    state.mode = rem(state.mode, 3) + pressed;
end

function renderFrame(~, ~); end
