
cd(fileparts(which('extractStimResponse_TOJ_analysis_a1355e')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','..','data');

sid = 'a1355e';

for s = 1:2
    % load in data
    if s == 1
        load(fullfile(folderData,sid,'TOJ-1.mat'))
        block = '1';
    elseif s == 2
        load(fullfile(folderData,sid,'TOJ-2.mat'))
        block = '2';
        length1st = size(tact,1);
    end
    
    % load in data of interest
    if s == 1
        stim = Stim.data;
    else
        stim = [stim; Stim.data];
    end
    fsStim = Stim.info.SamplingRateHz;
    
    clear Stim
    
    clear ECO1 ECO2 ECO3
    
    if s ==1
        tact = Tact.data;
    else
        tact = [tact; Tact.data];
    end
    fsTact = Tact.info.SamplingRateHz;
    clear Tact
    
end

%%
% bad trial
bads = 14;
[stimTimes,trainTimes] = extract_stimulation_times_TOJ(tact,fsStim,bads);

% get that button press - threshold it
tact(tact(:,2) >= 0.009,2) = 0.009;

% check to makes ure it all is working
%[buttonPksTemp,buttonLocsTemp] = findpeaks(tact(:,2),fsTact,'minpeakdistance',2,'Minpeakheight',0.008);

tact(tact(:,2) < 0.009,2) = 0;
tact(:,2) = tact(:,2)*1000;


%%
% plot  inputs continuously through time
if plotIt
    plot_TOJ_concurrently(stim,tact,fsStim)
end

% QUANTIFY RXN TIME TO CORTICAL STIM

[epochedTactor,epochedAudio,epochedStim,epochedButton,t,tSamps] = extract_epochs_TOJ(stim,tact,trainTimes,fsStim);
% epoched button press
%%

% give list of which were perceived first
whichPerceived = {'stim','same','stim','stim','tactor','same','tactor','stim','stim','stim','tactor','same','stim',...
    'stim','stim','tactor','stim','tactor','stim','tactor','stim'};
whichPerceiveMoresame = {'stim','same','stim','stim','tactor','same','tactor','stim','same','same','tactor','same','stim',...
    'stim','same','tactor','stim','tactor','stim','tactor','stim'};

numTrials = size(epochedAudio,2);

if plotIt
    plot_epochs_TOJ(epochedStim,epochedTactor,epochedAudio,epochedButton,whichPerceived,t,numTrials)
end


%%

[tactorLocsVec,stimLocsVec,buttonLocsVec,tactorStimDiff,responseTimes] = get_response_timing_segs_TOJ(epochedButton,epochedTactor,epochedStim,t,tSamps,numTrials);

%%
if saveIt
    current_direc = pwd;
    
    save(fullfile(current_direc, [sid '_TOJ_matlab.mat']),'tactorStimDiff','responseTimes','t','trainTimes',...,
        'fsStim','epochedButton','epochedTactor','epochedAudio','epochedStim');
end
