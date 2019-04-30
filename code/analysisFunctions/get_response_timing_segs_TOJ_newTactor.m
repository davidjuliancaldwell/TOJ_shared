function [tactorLocsVec,stimLocsVec,buttonLocsVec,tactorStimDiff,responseTimes] = get_response_timing_segs_TOJ_newTactor(epochedButton,epochedTactor,epochedStim,t,tSamps,numTrials)


tactThresh = 0.97;
epochedTactor(epochedTactor > tactThresh) = tactThresh;

for j = 1:numTrials
    
    [buttonPksTemp,buttonLocsTemp] = findpeaks((epochedButton(t>0,j)),t(t>0),'NPeaks',1,'Minpeakheight',3);
    [buttonPksTempSamps,buttonLocsTempSamps] = findpeaks((epochedButton(tSamps>0,j)),tSamps(tSamps>0),'NPeaks',1,'Minpeakheight',0.008);
    
    sprintf(['button ' num2str(buttonLocsTemp)])
    sprintf(['button ' num2str(buttonLocsTempSamps)])
    
    
    [tactorPksTemp,tactorLocsTemp] = findpeaks((epochedTactor(:,j)),t,'NPeaks',1,'Minpeakheight',tactThresh-0.05);
    [tactorPksTempSamps,tactorLocsTempSamps] = findpeaks((epochedTactor(:,j)),tSamps,'NPeaks',1,'Minpeakheight',tactThresh-0.05);
    
    sprintf(['tactor ' num2str(tactorLocsTemp)])
    sprintf(['tactor ' num2str(tactorLocsTempSamps)])
    
    [stimPksTemp,stimLocsTemp] = findpeaks((epochedStim(:,j)),t,'NPeaks',1,'Minpeakheight',1);
    [stimPksTempSamps,stimLocsTempSamps] = findpeaks((epochedStim(:,j)),tSamps,'NPeaks',1,'Minpeakheight',1);
    
    sprintf(['stim train ' num2str(stimLocsTemp)])
    sprintf(['tactor ' num2str(stimLocsTempSamps)])
    
    if isempty(buttonPksTemp)
        buttonPksTemp = NaN;
        buttonLocsTemp = NaN;
        buttonPksTempSamps = NaN;
        buttonLocsTempSamps = NaN;
    end
    
    if isempty(tactorPksTemp)
        tactorPksTemp = NaN;
        tactorLocsTemp = NaN;
        tactorPksTempSamps = NaN;
        tactorLocsTempSamps = NaN;
    end
    
    if isempty(stimPksTemp)
        stimPksTemp = NaN;
        stimLocsTemp = NaN;
        stimPksTempSamps = NaN;
        stimLocsTempSamps = NaN;
    end
    
    buttonPksVec(j) = buttonPksTemp;
    buttonLocsVec(j) = buttonLocsTemp;
    
    % do samples too
    buttonPksVecSamps(j) = buttonPksTempSamps;
    buttonLocsVecSamps(j) = buttonLocsTempSamps;
    
    tactorPksVec(j) = tactorPksTemp;
    tactorLocsVec(j) = tactorLocsTemp;
    
    tactorPksVecSamps(j) = tactorPksTempSamps;
    tactorLocsVecSamps(j) = tactorLocsTempSamps;
    
    stimPksVec(j) = stimPksTemp;
    stimLocsVec(j) = stimLocsTemp;
    
    stimPksVecSamps(j) = stimPksTempSamps;
    stimLocsVecSamps(j) = stimLocsTempSamps;
    
end

%% calculate Differences
tactorStimDiff = tactorLocsVec - stimLocsVec;

responseTimes = buttonLocsVec - min(tactorLocsVec,stimLocsVec);


end