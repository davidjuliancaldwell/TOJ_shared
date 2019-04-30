
cd(fileparts(which('extractStimResponse_TOJ_analysis_822e26')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','..','data');

sid = '822e26';
load(fullfile(folderData,sid,'TOJ-1.mat'))
%%
% load in data of interest
stim = Stim.data;

fsStim = Stim.info.SamplingRateHz;

clear Stim

clear ECO1 ECO2 ECO3

tact = Tact.data;

fsTact = Tact.info.SamplingRateHz;
clear Tact
%%
% get that button press - threshold it
tact(tact(:,2) >= 0.009,2) = 0.009;

% check to makes ure it all is working
%[buttonPksTemp,buttonLocsTemp] = findpeaks(tact(:,2),fsTact,'minpeakdistance',2,'Minpeakheight',0.008);

tact(tact(:,2) < 0.009,2) = 0;
tact(:,2) = tact(:,2)*1000;

%plot  inputs continuously through time
if plotIt
    plot_TOJ_concurrently(stim,tact,fsStim)
end
%%
% QUANTIFY RXN TIME TO CORTICAL STIM
[trainTimes,trainTimes] = extract_stimulation_times_TOJ_readIn_v2(tact,fsStim,[]);

% the last 4 were not recorded on the TDT for which one came first 
trainTimes = trainTimes(1:82); 
trainTimes = trainTimes(1:82);
%%
[epochedTactor,epochedAudio,epochedStim,epochedButton,t,tSamps] = extract_epochs_TOJ(stim,tact,trainTimes,fsStim);
% epoched button press


%%
% since the MATLAB file didn't save, have to compute it from the data
% stream
timing = diff(Vars.data(:,1));
[index,valus] = find(timing~=0);
%diffIndex = diff(index);
%preIndex = (timing(index-2));
%indicesInterest = [(diffIndex<1.214e5); 0];
%beginResponse = index(find(indicesInterest>0))
beginResponse = index(timing(index)>0);
feltFirstVec = timing(beginResponse);
% map 0 to tactor first, map 1 to stim first
stimFirst = ismember(feltFirstVec,1);
tactorFirst = ismember(feltFirstVec,2);
whichPerceived = zeros(size(feltFirstVec));
whichPerceived(stimFirst) = 1;
whichPerceived(tactorFirst) = 0;
%%
numTrials = size(epochedAudio,2);

if plotIt
    plot_epochs_TOJ(epochedStim,epochedTactor,epochedAudio,epochedButton,whichPerceived,t,numTrials)
end

%%
[tactorLocsVec,stimLocsVec,buttonLocsVec,tactorStimDiff,responseTimes] = get_response_timing_segs_TOJ_newTactor(epochedButton,epochedTactor,epochedStim,t,tSamps,numTrials);

%%
if saveIt
    current_direc = pwd;  
    save(fullfile(current_direc, [sid '_TOJ_matlab.mat']),'tactorStimDiff','responseTimes','t','trainTimes',...,
        'fsStim','epochedButton','epochedTactor','epochedAudio','epochedStim','whichPerceived');
end
