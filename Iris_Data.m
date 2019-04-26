%% Written by Shayan Taheri
% The code for fetching the images instances of the right iris of users
% There should be 5 image instances for the iris of each person
%% Preparing the Environment
clear all; close all; clc;

Path_Src = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Initial';
cd(Path_Src);
addpath(Path_Src);

Path_Dst = 'C:\Users\shaya\Desktop\Milad Work\Datasets\Original_Iris';
cd(Path_Dst);
addpath(Path_Dst);

set_dir = dir(Path_Src);
fileID = fopen('C:\Users\shaya\Desktop\Milad Work\Datasets\Iris_Users.txt','w');
for iw = 3:length(set_dir)
    cd(Path_Src);
    img_dir = [set_dir(iw).name,'\R'];
    img_data = dir(img_dir);
    if (length(img_data) < 7)
        continue;
    end
    
    cd(Path_Dst);
    mkdir(set_dir(iw).name);
    cd([Path_Src,'\',img_dir]);
    for iv = 3:7
        src_vec = [img_data(iv).name];
        des_vec = [Path_Dst,'\',set_dir(iw).name];
        copyfile(src_vec,des_vec);
    end
    fprintf(fileID,set_dir(iw).name);
    fprintf(fileID,'\n');
end
fclose(fileID);

dir_Riris = dir(Path_Dst);
cd(Path_Dst);
for ir = 3:length(dir_Riris)
    if ((ir-2) < 10)
        movefile(dir_Riris(ir).name,['P0',num2str(ir-2)]);
    else
        movefile(dir_Riris(ir).name,['P',num2str(ir-2)]);
    end
end
