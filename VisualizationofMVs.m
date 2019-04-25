clc;
clear all;
close all;
inPath = 'C:\Users\christ\Desktop\crowd_new\crowd_cfsas_db\';
newflnum='crowd001';
mvx = load([inPath,newflnum,'_MVx.mat']);
mvy = load([inPath,newflnum,'_MVy.mat']);
mvx=mvx.MVx_eff;
mvy=mvy.MVy_eff;
for i = 1:size(mvx,3)
    figure(1),quiver(squeeze(mvx(:,:,i)),squeeze(mvy(:,:,i)),0); 
    axis ij; 
    title(num2str(i)); 
    pause; 
end