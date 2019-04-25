clc;
clear all;
close all;
D=dir('/home2/praveen/data');
D1=D(3:end);
for i=1:212
    fldr_path=D1(i).name;     
    fldr_fle=strcat('/home2/praveen/data/',fldr_path);
    files =  dir(fullfile(fldr_fle,'*.jpg')) ;   %# list all *.xyz files
        for k=1:size(files)
            filesimg = files(k).name;                      
            myfile=strcat(fldr_fle,'/',filesimg);
            img=imread(myfile);
            imgref=imresize(img,[352 640]);
            flname=strcat(fldr_fle,'/',filesimg);
            imwrite(imgref,flname,'Quality',100);
        end
end
imshow(imgref);