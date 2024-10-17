function contestMovieGenerator(options)
    arguments
        options.audioFilename {mustBeTextScalar} = 'audio.wav';         % User-supplied and trimmed audio file
        options.totalDuration (1,1) {mustBeInteger} = 12;               % seconds; must be a multiple of segmentDuration
        options.segmentDuration (1,1) {mustBeInteger} = 4;              % seconds
        options.framesPerSecond (1,1) {mustBeInteger} = 24;
        options.outputFilename {mustBeTextScalar} = 'matlab_video.avi'; % Final output file
        options.drawframe function_handle 
    end
    numberOfLoops = options.totalDuration / options.segmentDuration;
    assert(mod(numberOfLoops,1)==0, 'totalDuration must be a multiple of segmentDuration.')
    
    % Generate a single 4-second video segment
    segmentNumFrames = options.segmentDuration * options.framesPerSecond;
    frameData = captureFrames(segmentNumFrames, options.drawframe);
    
    % Add audio to the file
    if exist(options.audioFilename, 'file') == 2
        [audioData, audioSampleRate] = audioread(options.audioFilename,'double');
        audioDurationSeconds = height(audioData) / audioSampleRate;
        if audioDurationSeconds < options.totalDuration
            repeatTimes = ceil(options.totalDuration / audioDurationSeconds);
            audioData = repmat(audioData, repeatTimes, 1);
            % Trim the audio to exactly match the total duration to ensure synchronization
            audioData = audioData(1:(audioSampleRate * options.totalDuration), :); 
        end
    else
        audioSampleRate = 44100; % Standard sample rate
        audioData = zeros(audioSampleRate * options.totalDuration, 2);
    end
    
    % The audio needs to be segemented for each frame. Since dividing the
    % number of samples in the audio by the total number of frames will likely
    % result in a fractional result which can't be used to index the audio
    % segments, we'll interpolate the audio data to ensure the number of samples is a
    % multiple of the total number of frames, allowing each segment to have
    % an integer number of samples.
    nTotalFrames = segmentNumFrames * numberOfLoops;
    modulo = mod(height(audioData),nTotalFrames+1);
    epandedAudioLength = height(audioData) + nTotalFrames+1-modulo;
    audioData = interp1(1:height(audioData), audioData, linspace(1,height(audioData),epandedAudioLength).');
    
    % Segment audio for each frame; This maps time 0 to frame 1 and time(end) to last frame
    nSamplesPerFrame = (height(audioData))/(nTotalFrames+1);
    audioStartStop = [1:nSamplesPerFrame:height(audioData); nSamplesPerFrame:nSamplesPerFrame:height(audioData)];
    
    % Initialize the video reader for the segment and writer for the final output
    videoFWriter = vision.VideoFileWriter(options.outputFilename, 'AudioInputPort', true, 'FrameRate', options.framesPerSecond);
    cleanupVidWriter = onCleanup(@()release(videoFWriter));
    
    % Loop through the segment to create the full-duration video
    for loop = 1:numberOfLoops
        for i = 1:segmentNumFrames
            nthFrame = segmentNumFrames*(loop-1)+i;
            audioFrame = audioData(audioStartStop(1,nthFrame):audioStartStop(2,nthFrame), :);
            videoFrame = frameData(i).cdata;
            videoFWriter(videoFrame, audioFrame);
        end
    end
end

function frameData = captureFrames(nFrames, drawframe)
    % Capture frames of an animation and return structure array containing
    % cdata field.
    arguments
        nFrames (1,1) {mustBeInteger}   % number of frames to collect
        drawframe function_handle 
    end
    figsize = [600, 600];
    frameData = struct('cdata',[],'colormap',[]);
    % Generate video segment
    for frame = 1:nFrames
        % Update animation and enforce standard figure size
        drawframe(frame);
        fig = gcf();
        fig.WindowStyle = 'normal'; 
        fig.Units = 'pixels';
        fig.Position(3:4) = figsize;
        % Capture frame and standardize its size
        frameData(frame) = getframe(fig); 
        [height, width, ~] = size(frameData(frame).cdata);
        if height ~= figsize(1) || width ~= figsize(2)
            frameData(frame).cdata = imresize(frameData(frame).cdata, figsize);
        end
    end
    close all force
end
