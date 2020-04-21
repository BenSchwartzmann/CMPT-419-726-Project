clear 
close all

load rr_interval_normal_final2

%%
k=1;
for i=[2:4 6:7 9:18]
    i
    j=1;
    for j=1:13
        image_normal2(:,:,k) = get_poincare_image(rr_interval_normal_final2{i,j});
        j=j+1;
        k=k+1;
    end
end

%%
for i=1:12
    figure(i)
    for k=1:20
        subplot(4,5,k)
        imagesc(image_normal(:,:,(i-1)*20+k))
        colormap(gray)
        set(gca,'YDir','normal')    
    end
end

%%
save 'image_normal2' image_normal2
