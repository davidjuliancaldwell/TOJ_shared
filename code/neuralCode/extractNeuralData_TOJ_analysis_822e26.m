cd(fileparts(which('extractStimResponse_TOJ_analysis_822e26')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','..','data');

sid = '822e26';
load(fullfile(folderData,sid,'TOJ-1.mat'))

block = '1';

% uneven blocks
ECoG = 4*cat(2,ECO1.data(3:end,:),ECO2.data(3:end,:),ECO3.data);
%stim = Stim.data;
%tact = Tact.data;


fsData = ECO1.info.SamplingRateHz;
% fsStim = Stim.info.SamplingRateHz;
% fsTact = Tact.info.SamplingRateHz;
clearvars ECO1 ECO2 ECO3 Stim Tact

%  % get rid of bad channels
bads = [93:128];

goodVec = logical(ones(size(ECoG,2),1));
goodVec(bads) = 0;
ECoG = ECoG(:,goodVec);

% convert sampling rate

% fac = fsTact/fsData;
fac = 2;

stimChans = [63 62];


load(fullfile(folderData,sid,'822e26_TOJ_matlab.mat'));

%% define what to epoch around for centering on stim trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trainTimesConverted = round(trainTimes/fac) + round(fsData*0.8) ; % convert from the tactor sampling rate to the eco sampling rate, it is centered around the stim train

preTime = 1000; % ms
postTime = 2000; % ms
preSamps = round(preTime*fsData/1e3); % convert time to samps
postSamps = round(postTime*fsData/1e3); % convert time to samps
tEpoch = [-preSamps:postSamps-1]/fsData;

% get signal epochs
epochedECoG = getEpochSignal(ECoG,trainTimesConverted -preSamps,trainTimesConverted +postSamps); % break up the ECoG into chunks

%% behavioral data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% delays manually used
delays = tactorStimDiff;

% tactor = 0
% stim = 1
firstFeel = whichPerceived;

%%
if saveIt
    current_direc = pwd;
    save(fullfile(current_direc, [sid '_TOJ_neural.mat']),'epochedECoG','tEpoch','fsData','delays','firstFeel','stimChans','badChans','-v7.3');
end

