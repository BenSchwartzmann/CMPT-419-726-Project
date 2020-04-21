clear
close all

list1={'files/04015','files/04043','files/04048','files/04126',...
    'files/04746','files/04908','files/04936','files/05091',...
    'files/05121','files/05261','files/06426','files/06453',...
    'files/06995','files/07162','files/07859','files/07879',...
    'files/07910','files/08215','files/08219','files/08378',...
    'files/08405','files/08434','files/08455'};

filename=list1{1};

[signal, Fs, tm] = rdsamp(filename,[]);

ann_Beat = rdann(filename,'atr');
%%
figure()
plot(tm, signal(:,1)); hold on; grid on
plot(tm(ann_Beat),signal(ann_Beat,1),'ro','MarkerSize',6)

%%
l=1;
for i=[2:2:14]

window = ann_Beat(i):ann_Beat(i+1);

size_diff=2*250*60-length(window);
if size_diff>0
    if mod(size_diff,2) == 0
        window_final = window(1)-size_diff/2:window(end)+size_diff/2;
    else
        window_final = window(1)-(size_diff-1)/2:window(end)+(size_diff-1)/2+1;
    end
else
    window_final = window(1):window(1)+2*250*60-1;
end



signal_temp = signal(window_final,:);

signalfilt= filt_file(signal_temp,Fs);


time_temp = tm(window_final,1);
% ann_Beat_temp = ann_Beat(ann_Beat>(window(1))&(ann_Beat<window(end)));
% 
% figure()
% plot(time_temp,signalfilt(:,1)); 
% hold on; grid on
% plot(time_temp(ann_Beat_temp),signalfilt(ann_Beat_temp,1),'ro','MarkerSize',6)

[qrs_amp_raw_temp2,qrs_i_raw_temp2,delay_temp2]=pan_tompkin(signalfilt(:,1),Fs,0);

% figure()
% plot(time_temp, signalfilt(:,1)); hold on; grid on
% plot(time_temp(qrs_i_raw_temp2),signalfilt(qrs_i_raw_temp2,1),'k*','MarkerSize',8)


a=diff(time_temp(qrs_i_raw_temp2));
% figure
% plot(a,'+-')


im = get_poincare_image(a);

figure(20)
subplot(4,5,l)
imagesc(im)
colormap(gray)
set(gca,'YDir','normal') 


% load rr_interval_afib_final
% 
% rr_interval_afib_final{22,l}=a;
% save 'rr_interval_afib_final' rr_interval_afib_final

l=l+1;

end
%

