function [] = plot_epochs_TOJ(epochedStim,epochedTactor,epochedAudio,epochedButton,whichPerceived,t,numTrials)

[p,n]=numSubplots(numTrials);
figure

for i = 1:numTrials
    subplot(p(1),p(2),i)
    hold on
    plot(t,epochedStim(:,i),'linewidth',2)
    plot(t,epochedTactor(:,i),'linewidth',2)
    plot(t,epochedAudio(:,i),'linewidth',2)
    plot(t,epochedButton(:,i),'linewidth',2)
    if iscell(whichPerceived)
        title(whichPerceived{i})
    else
        title(whichPerceived(i))
    end
    xlabel('time (s)')
    ylim([-6 6])
end
legend({'stim','tactor','audio train','button'})
end