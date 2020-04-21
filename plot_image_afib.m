clear 
close all
%%
load rr_interval_afib_final

%%
k=1;
for i=[1:2 4:9 11:17 19:23]
    j=1;
    while ~isempty(rr_interval_afib_final{i,j}) && j<27
        image_afib(:,:,k) = get_poincare_image(rr_interval_afib_final{i,j});
        j=j+1;
        k=k+1;
    end
end

%%
for i=1:12
    figure(i+1)
    for k=1:20
        subplot(4,5,k)
        imagesc(image_afib(:,:,(i-1)*20+k))
        colormap(gray)
        set(gca,'YDir','normal')    
    end
end

%%
% save 'image_afib' image_afib
