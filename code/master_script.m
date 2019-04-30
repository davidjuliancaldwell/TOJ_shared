%% TOJ master script

extractBehavioral = 1;
extractNeural = 1;
%% behavioral data

saveIt = 0;
plotIt = 1;

if extractBehavioral
    
    extractStimResponse_TOJ_analysis_a1355e
    extractStimResponse_TOJ_analysis_3ada8b
    extractStimResponse_TOJ_analysis_822e26
    
end

%% neural data

saveIt = 0;
if extractNeural
    
    extractNeuralData_TOJ_analysis_a1355e
    extractNeuralData_TOJ_analysis_3ada8b
    extractNeuralData_TOJ_analysis_822e26
    
end