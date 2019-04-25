clc;
clear all;
close all;
inPath = '/home2/praveen/crowd_database/';
newflnum='crowd002';
QP = load([inPath,newflnum,'_MB_QP.mat']);
%mvy = load([inPath,newflnum,'_MVy.mat']);
QP=QP.QP_eff;
for i = 1:367 
    figure(1),plot(squeeze(QP(:,:,i))); 
    axis ij; 
    title(num2str(i)); 
    pause; 
end