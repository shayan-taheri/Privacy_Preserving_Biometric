%% The Code for Segmentation and Normalization of Iris Dataset
clear all; close all; clc;

Original_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Iris_Issues';
Normalized_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Iris_Issues_Normalized';
Template_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Iris_Issues_Template';
Circles_Path = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Circles_Issues';
addpath('C:\Users\shaya\Desktop\Milad Work\Datasets\Hough');

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