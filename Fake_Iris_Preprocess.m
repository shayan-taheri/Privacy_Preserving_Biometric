%% The Code for Segmentation and Normalization of Fake Iris Dataset
clear all; close all; clc;

Original_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Initial_Fake_Iris';
Normalized_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Normalized_Fake_Iris';
Template_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Template_Fake_Iris';
addpath('C:\Users\shaya\Desktop\Milad Work\Datasets\Daugman');

orig_dir = dir(Original_Path);
fileID = fopen('C:\Users\shaya\Desktop\Milad Work\Datasets\Fake_Users.txt','w');
for ib = 1:50
    iy = floor(rand()*length(orig_dir)+3); % From 3 To length(orig_dir)!
    User_Name = orig_dir(iy).name;
    img_dir = dir([Original_Path,'\',User_Name]);
    for iq = 3:7
        Image_Name = img_dir(iq).name;
        iris_proc(Original_Path,Normalized_Path, ...
                        Template_Path,User_Name,Image_Name);
    end
    fprintf(fileID,User_Name);
    fprintf(fileID,'\n');
end
fclose(fileID);