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
mag_check = zeros(size(mvx,1),size(mvx,2));  
frames=size(mvx,3)
mag = sqrt(mvx.^2 + mvy.^2);
for frameCount = 1:frames
    mag_checker  = (mag(:,:,frameCount) > 0) + mag_checker;
end
for l=1:size(mvx,1)*size(mvx,2)
    if (mag_checker(l)>mean(mean(mag_checker)))
        mag_check(l)=255;
    end
end
figure;
imagesc(mag_check);
mask=uint8(zeros(size(mvx,1),size(mvx,2)));
[Ilabel num]=bwlabel(mag_check);
disp(num)
Iprops=regionprops(Ilabel);
Ibox=[Iprops.BoundingBox];
Ibox=reshape(Ibox,[4 num]);
m=1;
for l=1:num
    if (Ibox(3,l)<50)
        Iobj(:,m)=Ibox(:,l);
        m=m+1;
    end
end
for cnt=1:m-1
    a=floor(Iobj(2,cnt));
    if(a==0)
        a=1;
    end
    b=floor(Iobj(2,cnt)+Iobj(4,cnt));
    if(b>size(mvx,1))
        b=size(mvx,1);
    end
    c=floor(Iobj(1,cnt));
    if(c==0)
        c=1;
    end
    d=floor(Iobj(1,cnt)+Iobj(3,cnt));
    if(d>size(mvx,2))
        d=size(mvx,2);
    end
    mag_check(a:b,c:d)=mask(a:b,c:d);  
end

BW=bwmorph(mag_check,'close');
BW=bwmorph(mag_check,'open');

k=1;
mask2=zeros(size(mvx,1),size(mvx,2));
for k=1:size(mvx,1)*size(mvx,2)
    if(BW(k)==1)
        mask2(k)=255;
    end
end

mvx_eff2=mean(mvx,3);
mvy_eff2=mean(mvy,3);
k=1;
for k=1:size(mvx,1)*size(mvx,2)
    if(mask2(k)==0)
        mvx_eff2(k)=0;
        mvy_eff2(k)=0;
    end
end
figure;
quiver(mvx_eff2,mvy_eff2,0);
axis ij;
save('mvy_eff2','mvy_eff2');
save('mvx_eff2','mvx_eff2'); 
 