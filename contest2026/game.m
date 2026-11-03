function g = game()
%game Your one-button game.
%
%   Build your game by filling in the three functions below:
%   initState, updateState, and renderFrame. See README.md for the
%   full contract, idioms, and a worked example.
%
%   Workflow:
%       >> minihackContest.validate   % check the contract and contest rules
%       >> minihackContest.play       % play locally at 30 fps
%       >> minihackContest.submit     % publish to the contest

g.init   = @initState;
g.update = @updateState;
g.render = @renderFrame;
end

function state = initState(ax)
% Called once. Set up your world and build your initial state.
% Create every graphics object you'll need here -- renderFrame should
% only update their properties, never create new ones. The harness
% already configured `ax` with an 800x600 world; override XLim/YLim
% here if your game wants different world coordinates.

state = struct();   % replace with your own fields, e.g.
%   state.x = 400;
%   state.player = rectangle(ax, 'Position', [state.x 300 30 30]);
end

function state = updateState(state, dt, pressed)
% Called every frame. Advance state by dt seconds. `pressed` is
% true on the frame SPACE or a click was fired since the last
% frame (edge-triggered -- one `true` per discrete press). Scale
% all motion by dt so the game plays the same on any machine.
end

function renderFrame(~, state)
% Called every frame after updateState. Push your state onto the
% graphics objects you created in initState. Do NOT call drawnow.
%   state.player.Position = [state.x 300 30 30];
end
