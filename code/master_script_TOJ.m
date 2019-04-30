%% TOJ master script

extractBehavioral = 1;
extractNeural = 1;
%% behavioral data

saveIt = 0;
plotIt = 1;

if extractBehavioral
    
    fprintf(['----Begin Extracting Behavioral Data---- \n'])
    
    extractStimResponse_TOJ_analysis_a1355e
    fprintf(['----Subject %s done---- \n'],'a1355e')
    
    extractStimResponse_TOJ_analysis_3ada8b
    fprintf(['----Subject %s done---- \n'],'3ada8b')
    
    extractStimResponse_TOJ_analysis_822e26
    fprintf(['----Subject %s done---- \n'],'822e26')
    
    fprintf(['----Done Extracting Behavioral Data---- \n'])
    
end

%% neural data

saveIt = 0;
if extractNeural
    fprintf(['----Begin Extracting Neural Data---- \n'])
    
    extractNeuralData_TOJ_analysis_a1355e
    fprintf(['----Subject %s done---- \n'],'a1355e')
    
    extractNeuralData_TOJ_analysis_3ada8b
    fprintf(['----Subject %s done---- \n'],'3ada8b')
    
    extractNeuralData_TOJ_analysis_822e26
    fprintf(['----Subject %s done---- \n'],'822e26')
    
    
    fprintf(['----Done Extracting Neural Data---- \n'])
    
    
end