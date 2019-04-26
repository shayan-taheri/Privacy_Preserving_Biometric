%% Written by Shayan Taheri
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\Extra_Test';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    cd(Path);
    dir_name = set_dir(iz).name;
    cd([Path,'\',dir_name]);
    img_dir = dir([Path,'\',dir_name]);
    for it = 3:length(img_dir)
       movefile(img_dir(it).name,[img_dir(it).name(1:(end-3)),'jpg']); 
    end
end
