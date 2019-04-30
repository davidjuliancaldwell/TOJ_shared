function [] = plot_TOJ_concurrently(stim,tact,fsStim)

figure
hold on
t = [0:length(tact(:,1))-1]/fsStim;
plot(t,stim(:,1),'linewidth',2)
plot(t,tact(:,1),'linewidth',2)
plot(t,tact(:,4),'linewidth',2)
plot(t,tact(:,2),'linewidth',2)
legend({'stim','tactor','audio train','button'})
%vline(trainTimes/fs_stim)


end