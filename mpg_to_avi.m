clc;
clear all;
close all;
inPath = '/home2/praveen/crowd_cfsas_db/';
crowds=1;
for crowds =1:7
       k=num2str(crowds);
        if (numel(num2str(k))==1)
            newflnum=strcat('crowd00',num2str(k));
        elseif(numel(num2str(k))==2)
            newflnum=strcat('crowd0',num2str(k));
        elseif(numel(num2str(k))==3)
            newflnum=strcat('crowd',num2str(k));
        end
        file_name=strcat('/home2/praveen/crowd_cfsas_db/',newflnum,'.avi');
        video_file=VideoReader(file_name);        
        numberofframes=video_file.NumberOfFrames;
    
        videoobj=VideoWriter(strcat(file_name(1:end-4),'_new.avi'));
         open(videoobj);
        for k=1:numberofframes
            frame=read(video_file,k);
            frame=imresize(frame,[352 480]);
            writeVideo(videoobj,frame);
        end
        close(videoobj);
end
