clear
close all

list1={'files/04015','files/04043','files/04048','files/04126',...
    'files/04746','files/04908','files/04936','files/05091',...
    'files/05121','files/05261','files/06426','files/06453',...
    'files/06995','files/07162','files/07859','files/07879',...
    'files/07910','files/08215','files/08219','files/08378',...
    'files/08405','files/08434','files/08455'};
list2={'normal/16265','normal/16272','normal/16273','normal/16420',...
    'normal/16483','normal/16539','normal/16773','normal/16786',...
    'normal/16795','normal/17052','normal/17453','normal/18177',...
    'normal/18184','normal/19088','normal/19090','normal/19093',...
    'normal/19140','normal/19830'};
filename=list2{1};

[signal, Fs, tm] = rdsamp(filename,[]);

ann_Beat = rdann(filename,'atr');
%%
figure()
plot(signal(:,1)); hold on; grid on
% plot(tm(ann_Beat),signal(ann_Beat,1),'ro','MarkerSize',6)

%%


window = ann_Beat(2):ann_Beat(3);

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

%%

for i=1:20
    window20(i,:)=1+0000000+2*(i-1)*60*250:0000000+2*i*60*250;
end

%%
l=1;
for p=1:20
window_final=window20(p,:);
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

figure(1)
subplot(4,5,p)
imagesc(im)
colormap(gray)
set(gca,'YDir','normal') 


% load rr_interval_afib_final
% 
rr_interval_to_test{1,l}=a;
save 'rr_interval_to_test' rr_interval_to_test

l=l+1;
end
%%

% save 'rr_interval_afib' rr_interval_afib