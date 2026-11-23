function g = music_and_cheers()
    g.init   = @initState;
    g.update = @updateState;
    g.render = @renderFrame;
end

function html = getHTML()
    html = [
        "<html><body><script>"
        "function setup(htmlComponent) {"
        "  const AC=window.AudioContext||window.webkitAudioContext;"
        "  const ctx=new AC();"
        "  const master=ctx.createGain();"
        "  master.gain.value=0.38;"
        "  master.connect(ctx.destination);"
        "  const bpm=124, beat=60/bpm, bar=4*beat;"
        "  let nextBar=0, timer=null, barNo=0;"
        "  const noiseBuffer=ctx.createBuffer(1,ctx.sampleRate*0.3,ctx.sampleRate);"
        "  const nd=noiseBuffer.getChannelData(0);"
        "  for(let i=0;i<nd.length;i++) nd[i]=Math.random()*2-1;"
        ""
        "  function kick(t,power=1) {"
        "    const o=ctx.createOscillator(),g=ctx.createGain();"
        "    o.type='sine';"
        "    o.frequency.setValueAtTime(150,t);"
        "    o.frequency.exponentialRampToValueAtTime(42,t+0.17);"
        "    g.gain.setValueAtTime(0.95*power,t);"
        "    g.gain.exponentialRampToValueAtTime(0.001,t+0.22);"
        "    o.connect(g);g.connect(master);"
        "    o.start(t);o.stop(t+0.23);"
        "  }"
        ""
        "  function noise(t,dur,vol,cut,type='highpass') {"
        "    const s=ctx.createBufferSource();"
        "    const f=ctx.createBiquadFilter(),g=ctx.createGain();"
        "    s.buffer=noiseBuffer;"
        "    f.type=type;f.frequency.value=cut;"
        "    g.gain.setValueAtTime(vol,t);"
        "    g.gain.exponentialRampToValueAtTime(0.001,t+dur);"
        "    s.connect(f);f.connect(g);g.connect(master);"
        "    s.start(t);s.stop(t+dur);"
        "  }"
        ""
        "  function bass(t,freq,dur=0.32) {"
        "    const o=ctx.createOscillator(),f=ctx.createBiquadFilter();"
        "    const g=ctx.createGain();"
        "    o.type='sawtooth';o.frequency.value=freq;"
        "    f.type='lowpass';f.frequency.value=420;"
        "    g.gain.setValueAtTime(0.22,t);"
        "    g.gain.exponentialRampToValueAtTime(0.001,t+dur);"
        "    o.connect(f);f.connect(g);g.connect(master);"
        "    o.start(t);o.stop(t+dur+0.02);"
        "  }"
        ""
        "  function brass(t,root) {"
        "    [root*2,root*3,root*4].forEach((freq,i)=>{"
        "      const o=ctx.createOscillator(),f=ctx.createBiquadFilter();"
        "      const g=ctx.createGain();"
        "      o.type='sawtooth';"
        "      o.frequency.value=freq;"
        "      o.detune.value=(i-1)*5;"
        "      f.type='lowpass';f.frequency.setValueAtTime(1500,t);"
        "      f.frequency.exponentialRampToValueAtTime(500,t+0.25);"
        "      g.gain.setValueAtTime(0.001,t);"
        "      g.gain.linearRampToValueAtTime(0.10,t+0.025);"
        "      g.gain.exponentialRampToValueAtTime(0.001,t+0.28);"
        "      o.connect(f);f.connect(g);g.connect(master);"
        "      o.start(t);o.stop(t+0.3);"
        "    });"
        "  }"
        ""
        "  function tom(t,freq) {"
        "    const o=ctx.createOscillator(),g=ctx.createGain();"
        "    o.type='sine';"
        "    o.frequency.setValueAtTime(freq,t);"
        "    o.frequency.exponentialRampToValueAtTime(freq*0.55,t+0.16);"
        "    g.gain.setValueAtTime(0.45,t);"
        "    g.gain.exponentialRampToValueAtTime(0.001,t+0.2);"
        "    o.connect(g);g.connect(master);"
        "    o.start(t);o.stop(t+0.21);"
        "  }"
        ""
        "  const roots=[82.41,65.41,98,73.42];"
        "  function scheduleBar(t,n) {"
        "    const root=roots[n%4];"
        "    for(let i=0;i<4;i++){"
        "      const at=t+i*beat;"
        "      kick(at,(i===0||i===2)?1:0.75);"
        "      bass(at,[root,root,root*1.5,root][i]);"
        "      if(i===1||i===3) noise(at,0.16,0.34,1100,'bandpass');"
        "    }"
        "    for(let i=0;i<8;i++){"
        "      noise(t+i*beat/2,0.045,i%2?0.045:0.085,7500);"
        "    }"
        "    noise(t+3.5*beat,0.18,0.13,6500);"
        "    brass(t,root);"
        "    brass(t+2.5*beat,root);"
        "    if(n%4===3){"
        "      tom(t+2.5*beat,120);"
        "      tom(t+3*beat,160);"
        "      tom(t+3.5*beat,210);"
        "    }"
        "  }"
        ""
        "  function pump(){"
        "    while(nextBar<ctx.currentTime+0.25){"
        "      scheduleBar(nextBar,barNo++);"
        "      nextBar+=bar;"
        "    }"
        "  }"
        ""
        "  htmlComponent.addEventListener('startMusic',async()=>{"
        "    if(timer)return;"
        "    await ctx.resume();"
        "    nextBar=ctx.currentTime+0.05;"
        "    pump();"
        "    timer=setInterval(pump,50);"
        "  });"
        ""
        "  htmlComponent.addEventListener('clap',async()=>{"
        "    if(ctx.state==='suspended')await ctx.resume();"
        "    if(window.speechSynthesis){"
        "      window.speechSynthesis.cancel();"
        "      const u=new SpeechSynthesisUtterance('YO!');"
        "      u.lang='en-US'; u.rate=1.2; u.pitch=1.2; u.volume=1;"
        "      window.speechSynthesis.speak(u);"
        "    }"
        "  });"
        "}"
        "</script></body></html>"
    ];
    html = join(html,"");
end

function drawBackground(ax)
    % Background
    rectangle(ax,'Position',[0 0 800 600], ...
        'FaceColor',[0.012 0.018 0.055],'EdgeColor','none');
    % Stadium stands
    patch(ax,[0 0 800 800],[0 220 220 0], ...
        [0.045 0.055 0.13],'EdgeColor','none');
    patch(ax,[0 800 800 0],[600 600 430 430], ...
        [0.035 0.045 0.11],'EdgeColor','none');
    % Wide spotlight beams
    patch(ax,[65 180 410 260],[535 535 80 80], ...
        [0.12 0.25 0.75],'FaceAlpha',0.13,'EdgeColor','none');
    patch(ax,[95 145 350 280],[535 535 80 80], ...
        [0.25 0.45 1.0],'FaceAlpha',0.10,'EdgeColor','none');
    patch(ax,[735 620 390 540],[535 535 80 80], ...
        [0.65 0.12 0.48],'FaceAlpha',0.13,'EdgeColor','none');
    patch(ax,[705 655 450 520],[535 535 80 80], ...
        [1.0 0.25 0.55],'FaceAlpha',0.09,'EdgeColor','none');
    % Additional crossing spotlights
    patch(ax,[280 340 570 480],[530 530 80 80], ...
        [0.10 0.55 0.75],'FaceAlpha',0.09,'EdgeColor','none');
    patch(ax,[520 580 320 260],[530 530 80 80], ...
        [0.35 0.20 0.75],'FaceAlpha',0.09,'EdgeColor','none');
    % Bright inner light beams
    patch(ax,[105 125 330 300],[530 530 80 80], ...
        [0.35 0.55 1.0],'FaceAlpha',0.12,'EdgeColor','none');
    patch(ax,[695 675 500 470],[530 530 80 80], ...
        [1.0 0.40 0.65],'FaceAlpha',0.11,'EdgeColor','none');
    % Stadium roof and trusses
    plot(ax,[0 800],[550 550],'-','Color',[0.16 0.19 0.32],'LineWidth',8);
    plot(ax,[0 800],[540 540],'-','Color',[0.32 0.37 0.52],'LineWidth',2);
    for x = 0:40:800
        plot(ax,[x x+20],[540 550],'-', ...
            'Color',[0.18 0.22 0.36],'LineWidth',1);
    end
    % Stadium light panels
    for x = [90 710]
        rectangle(ax,'Position',[x-42 515 84 18], ...
            'FaceColor',[0.55 0.68 0.95], ...
            'EdgeColor',[0.75 0.82 1.0],'LineWidth',1);
        for k = 1:9
            plot(ax,x-32+(k-1)*8,524,'o', ...
                'MarkerSize',5,'MarkerFaceColor',[1 1 0.75], ...
                'MarkerEdgeColor','none');
        end
    end
    % Extra colored spotlights
    for x = [250 400 550]
        plot(ax,x,520,'o','MarkerSize',12, ...
            'MarkerFaceColor',[0.65 0.75 1.0], ...
            'MarkerEdgeColor','none');
        plot(ax,x,520,'o','MarkerSize',5, ...
            'MarkerFaceColor',[1 1 1], ...
            'MarkerEdgeColor','none');
    end
    % Crowd silhouettes
    for k = 1:220
        x = mod(k*137,800);
        y = 85+mod(k*71,125);
        r = 2+mod(k*13,4);
        plot(ax,x,y,'o','MarkerSize',r, ...
            'MarkerFaceColor',[0.15 0.18 0.30], ...
            'MarkerEdgeColor','none');
    end
    % Colorful audience lights
    colors = [0.3 0.65 1.0; 1.0 0.35 0.55; ...
              0.8 0.75 1.0; 0.3 1.0 0.8];
    for k = 1:100
        x = mod(k*193,800);
        y = 100+mod(k*89,110);
        c = colors(mod(k-1,4)+1,:);
        plot(ax,x,y,'.','MarkerSize',8,'Color',c);
    end
    % Stage
    patch(ax,[0 800 800 0],[0 0 85 85], ...
        [0.012 0.018 0.045],'EdgeColor','none');
    % LED panels
    for x = 30:50:770
        rectangle(ax,'Position',[x 15 25 45], ...
            'FaceColor',[0.025 0.07 0.16], ...
            'EdgeColor',[0.12 0.30 0.55],'LineWidth',1);
        plot(ax,[x+5 x+20],[25 25],'-', ...
            'Color',[0.1 0.55 1.0],'LineWidth',2);
    end
    % Stage edge lights
    for x = 10:18:790
        plot(ax,x,88,'o','MarkerSize',4, ...
            'MarkerFaceColor',[0.25 0.75 1.0], ...
            'MarkerEdgeColor','none');
    end
    % Center dark panel for game text
    rectangle(ax,'Position',[145 235 510 145], ...
        'FaceColor',[0.012 0.022 0.065], ...
        'FaceAlpha',0.82, ...
        'EdgeColor',[0.25 0.48 0.85], ...
        'LineWidth',2);
    % Panel highlights
    plot(ax,[145 655],[380 380],'-','Color',[0.35 0.65 1.0],'LineWidth',2);
    plot(ax,[145 655],[235 235],'-','Color',[0.25 0.40 0.75],'LineWidth',1);
end

function state = initState(ax)
    drawBackground(ax);
    state.started = false;
    state.audio = uihtml(ancestor(ax, 'figure'), 'HTMLSource', getHTML());

    state.message = text(ax, 400, 305, 'YO!', 'Color',[1 1 1], ...
        'FontSize', 140, 'FontWeight','bold', ...
        'HorizontalAlignment','center');
    state.messageTimer = 0;
end

function state = updateState(state, dt, pressed)
    if ~state.started
        state.started = true;
        sendEventToHTMLSource(state.audio, 'startMusic');
    end
    state.messageTimer = state.messageTimer-dt;
    if pressed
        sendEventToHTMLSource(state.audio, 'clap');
        state.messageTimer = 0.8;
    end
end

function renderFrame(~,state)
    if state.messageTimer > 0
        state.message.Visible = 'on';
    else
        state.message.Visible = 'off';
    end
end
