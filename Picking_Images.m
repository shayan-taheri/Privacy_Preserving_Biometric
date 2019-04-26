%% The script for separating the specific images of a dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation';
Dest = 'C:\Users\shaya\Desktop\Attacks\Dataset\Original_Fake_Fing';
cd(Path);
main_dir = dir(Path);

for ix = 3:length(main_dir)
    cd(Path);
    img_dir = dir([Path,'\',main_dir(ix).name,'\','fake']);
    for iy = 3:length(img_dir)
        if (img_dir(iy).name(8) == 'o')
            src_vec = img_dir(iy).name;
            cd([Path,'\',main_dir(ix).name,'\','fake']);
            copyfile(src_vec,Dest);
            cd(Dest);
            movefile(src_vec,[src_vec(1:(end-3)),'jpg']);
        end
    end
end

Path = 'C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithoutCooperation';

cd(Path);
main_dir = dir(Path);

for ix = 3:length(main_dir)
    cd(Path);
    img_dir = dir([Path,'\',main_dir(ix).name,'\','fake']);
    for iy = 3:length(img_dir)
        if (img_dir(iy).name(8) == 'o')
            src_vec = img_dir(iy).name;
            cd([Path,'\',main_dir(ix).name,'\','fake']);
            copyfile(src_vec,Dest);
            cd(Dest);
            movefile(src_vec,[src_vec(1:(end-3)),'jpg']);
        end
    end
end