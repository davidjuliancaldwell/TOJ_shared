cd(fileparts(which('extractNeuralData_TOJ_analysis_a1355e')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','..','data');

sid = 'a1355e';
for s = 1:2
    % load in data
    if s == 1
        load(fullfile(folderData,sid,'TOJ-1.mat'))
        block = '1';
        ECoG = cat(2,ECO1.data,ECO2.data,ECO3.data);
        %stim = Stim.data;
        %tact = Tact.data;
        
        
        clearvars ECO1 ECO2 ECO3 Stim tact
    elseif s == 2
        load(fullfile(folderData,sid,'TOJ-2.mat'))
        block = '2';
        ECoG = 4*[ECoG; cat(2,ECO1.data,ECO2.data,ECO3.data)];
        %stim = [stim; Stim.data];
        fsData = ECO1.info.SamplingRateHz;
       % fsStim = Stim.info.SamplingRateHz;
       % fsTact = Tact.info.SamplingRateHz;
        clearvars ECO1 ECO2 ECO3 Stim Tact
        
        % get rid of bad channels
        bads = [79:98];
        goodVec = logical(ones(size(ECoG,2),1));
        goodVec(bads) = 0;
        ECoG = ECoG(:,goodVec);
        
        % convert sampling rate
        
       % fac = fsTact/fsData;
        fac = 2;
        % stim chans, 16/24
        
        stimChans = [16 24];
        
    end
    
end
load(fullfile('a1355e_TOJ_matlab.mat'));

%% define what to epoch around for centering on stim trials 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trainTimes = round(trainTimes/fac) + round(1*fsData); % convert from the tactor sampling rate to the eco sampling rate, add one second to center it around the stim train

preTime = 1000; % ms
postTime = 2000; % ms
preSamps = round(preTime*fsData/1e3); % convert time to samps
postSamps = round(postTime*fsData/1e3); % convert time to samps
tEpoch = [-preSamps:postSamps-1]/fsData;

% get signal epochs
epochedECoG = getEpochSignal(ECoG,trainTimes-preSamps,trainTimes+postSamps); % break up the ECoG into chunks

%% behavioral data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% delays manually used
delays = [2700,2550,2500,2600,2700,2550,2700,2550,2550,2700,2800,2550,2400,2400,2800,2850,2400,2850,2400,2580,2400]-2700;

% tactor = 0
% stim = 1
% same = 2

firstFeel = [1,2,1,1,0,2,0,1,1,1,0,2,1,1,1,0,1,0,1,0,1]; % which did he feel first
firstFeel([8,9,14]+1) = 2;
% ones with slight edge for stim put back as same

%%
if saveIt
    current_direc = pwd;
    save(fullfile(current_direc, [sid '_TOJ_neural.mat']),'epochedECoG','tEpoch','fsData','delays','firstFeel','bads','stimChans','-v7.3');
end
