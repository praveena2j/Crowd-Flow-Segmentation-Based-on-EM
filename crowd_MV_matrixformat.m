%function MV_mat_formation; 
close all;
clear all;
clc;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inPath = '/home2/praveen/crowd_cfsas_db/';
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frame_height_factor = 8;
frame_width_factor  = 0;

for crowds = 1:7
    k=num2str(crowds);
    if (numel(num2str(k))==1)
        newflnum=strcat('crowd00',num2str(k));
    elseif(numel(num2str(k))==2)
        newflnum=strcat('crowd0',num2str(k));
    elseif(numel(num2str(k))==3)
        newflnum=strcat('crowd',num2str(k));
    end
    frame_size = load([inPath,newflnum,'_vid_res.dat']);
    MVxtemp = load([inPath,newflnum,'_MVx.dat']);
    MVytemp = load([inPath,newflnum,'_MVy.dat']);
    MB_QP_temp=load([inPath,newflnum,'_MB_QP.dat']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            
    frame_height = frame_size(1) + frame_height_factor;
    frame_width = frame_size(2) + frame_width_factor;
    frames = size(MVxtemp,1)/frame_height*4;
    %frames=35;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reshape the motion vector components 
    MVxtemp = reshape(MVxtemp',frame_width/4,frame_height/4,frames);
    MVytemp = reshape(MVytemp',frame_width/4,frame_height/4,frames);
    MB_QP_temp = reshape(MB_QP_temp',frame_width/16,frame_height/16,frames);
    %initialization of the net Motion vectors to zero  
    MVx = zeros(size(MVxtemp,2),size(MVxtemp,1),size(MVxtemp,3));
    MVy = zeros(size(MVytemp,2),size(MVytemp,1),size(MVytemp,3));
    MB_QP = zeros(size(MB_QP_temp,2),size(MB_QP_temp,1),size(MB_QP_temp,3));
    MVx_eff = round(permute(MVxtemp,[2 1 3])./4); 
    MVy_eff = round(permute(MVytemp,[2 1 3])./4);
    QP_eff = round(permute(MB_QP_temp,[2 1 3])./4);
    save([inPath,newflnum,'_MVx'],'MVx_eff');
    save([inPath,newflnum,'_MVy'],'MVy_eff');
    save([inPath,newflnum,'_MB_QP'],'QP_eff');
 end 
