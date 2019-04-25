clc;
clear all;
close all;
inPath = 'C:\Users\christ\Desktop\crowd_new\crowd_cfsas_db\';
newflnum='crowd002';
mvx = load([inPath,newflnum,'_MVx.mat']);
mvy = load([inPath,newflnum,'_MVy.mat']);
mvx=mvx.MVx_eff;
mvy=mvy.MVy_eff;
mag_checker = zeros(size(mvx,1),size(mvx,2));  
mag = zeros(size(mvx,1),size(mvx,2),size(mvx,3));
mag_check = zeros(size(mvx,1),size(mvx,2));  
frames=size(mvx,3);
for frameCount = 1:frames   
    framex=mvx(:,:,frameCount);
    for k=1:size(mvx,1)*size(mvx,2)
        if(framex(k) > 0.1*max(size(mvx,1),size(mvx,2)))
            framex(k)=max(max(framex));
        end   
    end
    mvx(:,:,frameCount)=framex;
    framey=mvy(:,:,frameCount);
    for k=1:size(mvy,1)*size(mvy,2)
        if(framey(k) > 0.1*max(size(mvy,1),size(mvy,2)))
            framey(k)=max(max(framey));
        end   
    end
    mvy(:,:,frameCount)=framey;
end
for frameCount = 1:frames
    mag = sqrt(mvx.^2 + mvy.^2);
    mag_checker          = (mag(:,:,frameCount) > 0) + mag_checker;
end

for l=1:size(mvx,1)*size(mvx,2)
    if (mag_checker(l)>20)
        mag_check(l)=255;
    end
end
figure;
imagesc(mag_check);
for k=1:frames
    frame_x=mvx(:,:,k);
    frame_y=mvy(:,:,k);
    for t=1:size(mvx,1)*size(mvx,2)
        if(uint8(mag_check(t))==0)
            frame_x(t)=0;
            frame_y(t)=0;
        end
    end
    mvx(:,:,k)=frame_x;
    mvy(:,:,k)=frame_y;
end
for m=1:size(mvx,1)
    for n=1:size(mvx,2)
        mvx_eff(m,n)=median(mvx(m,n,:));
        mvy_eff(m,n)=median(mvy(m,n,:));
    end
end
figure;
quiver(squeeze(mvx_eff),squeeze(mvy_eff),0); 
axis ij; 
angle_eff=atan2(mvy_eff,mvx_eff);
figure;
imagesc(angle_eff);

for p=1:size(mvx,1)*size(mvx,2)
    for q=1:2
        if(q==1)
            X(p,q)=mvx_eff(p);
        else
            X(p,q)=mvy_eff(p);
        end
    end
end 
V=X';
[C I]=yael_kmeans(single(V),4,'redo',35);
mv_final=zeros(size(mvx,1),size(mvx,2));
for p=1:size(mvx,1)*size(mvx,2)
    mv_final(p)=I(p);     
end
figure;
imagesc(mv_final)