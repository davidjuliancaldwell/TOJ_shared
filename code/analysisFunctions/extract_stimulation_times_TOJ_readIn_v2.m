function [stimTimes,trainTimes] = extract_stimulation_times_TOJ_readIn_v2(tact,fsStim,bads)
% this function works for the second subject (3ada8b) and on
% David.J.Caldwell, 8.9.2018 

%
samplesOfPulse = round(2*fsStim/1e3);
% build a burst table with the timing of stimuli
preStim = round(fsStim*0.8);

% use stimDelay, tact(:,7), which is 200 ms delayed + delay (tact:,6) to
% figure out when the stimulation train starts.
[trainTimes] = find(tact(:,7)==1)- preStim +round(fsStim*tact(find(tact(:,7)==1),6)/1e3);
logicalMask = logical(ones(size(trainTimes)));
logicalMask(bads) = 0;
trainTimes = trainTimes(logicalMask);
starts = trainTimes;
ends = trainTimes + samplesOfPulse;
delay = round(0.2867*fsStim/1e3);
% extract data
% try and account for delay for the stim times
stimTimes = starts+delay;
trainTimes=stimTimes;

end