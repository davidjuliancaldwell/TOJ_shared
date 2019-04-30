function [epochedTactor,epochedAudio,epochedStim,epochedButton,t,tSamps] = extract_epochs_TOJ(stim,tact,trainTimes,fsStim)

% QUANTIFY RXN TIME TO CORTICAL STIM
sampsEnd = round(3*fsStim);
preStim = round(fsStim*1);

epochedTactor = squeeze(getEpochSignal(tact(:,1),trainTimes,trainTimes+sampsEnd));
epochedAudio = squeeze(getEpochSignal(tact(:,4),trainTimes,trainTimes+sampsEnd));
epochedStim = squeeze(getEpochSignal(stim(:,1),trainTimes,trainTimes+sampsEnd));
epochedButton = squeeze(getEpochSignal(tact(:,2),trainTimes,trainTimes+sampsEnd)); 

t = [-preStim:sampsEnd-preStim-1]/fsStim;
tSamps = [-preStim:sampsEnd-preStim-1];

end