clear
% close all

list2={'normal/16265','normal/16272','normal/16273','normal/16420',...
    'normal/16483','normal/16539','normal/16773','normal/16786',...
    'normal/16795','normal/17052','normal/17453','normal/18177',...
    'normal/18184','normal/19088','normal/19090','normal/19093',...
    'normal/19140','normal/19830'};

for k=1:18
    k
filename=list2{k};
[signal, Fs, tm] = rdsamp(filename,[]);

if k==2 
   for i=1:13
        window10(i,:)=1+6000000+2*(i-1)*60*Fs:6000000+2*i*60*Fs;
    end 
elseif k==13|| k==16
for i=1:13
        window10(i,:)=1+5*60*Fs+2*(i-1)*60*Fs:5*60*Fs+2*i*60*Fs;
end

else
    for i=1:13
        window10(i,:)=1+(i-1)*500000+2*(i-1)*60*Fs:(i-1)*500000+2*i*60*Fs;
    end
end

for j=1:13
window_final = window10(j,:);
signal_temp = signal(window_final,:);

signalfilt= filt_file(signal_temp,Fs);


time_temp = tm(window_final,1);
% ann_Beat_temp = ann_Beat(ann_Beat>(window(1))&(ann_Beat<window(end)));
% 
% figure()
% plot(time_temp,signalfilt(:,1)); 
% hold on; grid on
% plot(time_temp(ann_Beat_temp),signalfilt(ann_Beat_temp,1),'ro','MarkerSize',6)
%
[qrs_amp_raw_temp2,qrs_i_raw_temp2,delay_temp2]=pan_tompkin(signalfilt(:,1),Fs,0);

% figure()
% plot(time_temp, signalfilt(:,1)); hold on; grid on
% plot(time_temp(qrs_i_raw_temp2),signalfilt(qrs_i_raw_temp2,1),'k*','MarkerSize',8)

%
a=diff(time_temp(qrs_i_raw_temp2));
% figure
% plot(a,'+-')
rr_interval_normal_final2{k,j}=a;
%
im = get_poincare_image(a);

figure(k)
subplot(2,7,j)
imagesc(im)
colormap(gray)
set(gca,'YDir','normal') 
end

end