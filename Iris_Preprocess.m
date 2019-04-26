%% The Code for Segmentation and Normalization of Iris Dataset
clear all; close all; clc;

Original_Path = '???';
Normalized_Path = '???';
Template_Path = '???';
Circles_Path = '???';
addpath('C:\Users\shaya\Desktop\Milad Work\Datasets\Daugman');

orig_dir = dir(Original_Path);

for iy = 3:length(orig_dir)
    User_Name = orig_dir(iy).name;
    img_dir = dir([Original_Path,'\',User_Name]);
    for iq = 3:length(img_dir)
        Image_Name = img_dir(iq).name;
        iris_proc(Original_Path,Normalized_Path, ...
                        Template_Path,Circles_Path,User_Name,Image_Name);
    end
end