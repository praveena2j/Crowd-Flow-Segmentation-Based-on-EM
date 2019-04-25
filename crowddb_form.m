clc;
clear all;
close all;
D=dir('/home2/praveen/data');
D1=D(3:end);
%i=3;
for i=4:212
    fldr_path=D1(i).name;     
    fldr_fle=strcat('/home2/praveen/data/',fldr_path);
    files =  dir(fullfile(fldr_fle,'*.avi')) ;   %# list all *.xyz files
    files = files.name;                      %'# file names
    myfile=strcat(fldr_fle,'/',files);
    movefile(myfile);
    oldflname=files;
    newflname=strcat('crowd',num2str(i),'.avi');
    movefile(oldflname,newflname);
end