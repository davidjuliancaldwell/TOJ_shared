sids = {'a1355e','3ada8b','822e26'};
stimChansVec = [16 24; 4 3; 62 63 ];



cd(fileparts(which('plot_TOJ_subject_brains')));
locationsDir = pwd;
folderSubj = fullfile(locationsDir, '..','..','data');
setenv('subject_dir', folderSubj);


%% plot all electrodes
for sid = sids
    sid = sid{:};
    figure
    PlotCortex(sid,'b',[],1)
    hold on
    PlotElectrodes(sid)
end


%% plot just stim
index = 1;
for sid = sids
    sid = sid{:};
    
    PlotBrainJustDots(sid,{stimChansVec(index,:)},[0 0 0; 0 0 0])
    index = index + 1;
end

