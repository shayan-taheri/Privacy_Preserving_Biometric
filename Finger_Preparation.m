% Written by Shayan Taheri
%% Read and Rename the Folders in Fingerprint Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\With_Cooperation';
cd(Path);
addpath(Path);
set_dir = dir(Path);
for iq = 3:length(set_dir)
    cd(Path);
    dir_proc = dir(set_dir(iq).name);
    for iw = 3:length(dir_proc)
       cd([Path,'\',set_dir(iq).name]);
       im_dir = dir(dir_proc(iw).name);
       cd([Path,'\',set_dir(iq).name,'\',dir_proc(iw).name]);
       for ie = 3:length(im_dir)
           if (strcmp(im_dir(ie).name,'Thumbs.db') || (im_dir(ie).name(8) ~= 'o'))
               delete(im_dir(ie).name);
           else
               movefile(im_dir(ie).name,[im_dir(ie).name(1:(end-3)),'jpg']);
           end
       end
    end
end
% --------------------------------------------------------------------------------
%% Read and Rename the Folders in Fingerprint Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\With_Cooperation';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    if ((iz - 2) <= 9)
        movefile(dir_name,['P',num2str(0),num2str(iz-2)]);
    else
        movefile(dir_name,['P',num2str(iz-2)]);
    end
end
% --------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\Without_Cooperation';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    set_dirL = dir([dir_name,'\Fake']);
    set_dirR = dir([dir_name,'\True']);
    if ((length(set_dirL) < 18) || (length(set_dirR) < 18))
        fprintf([dir_name,',']);
    end
end
fprintf('\n');
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\With_Cooperation';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    cd([Path,'\',dir_name]);
    movefile('fake','temp');
    movefile('temp','Fake');
    movefile('original','True');
end
fprintf('\n');
% -------------------------------------------------------------------------------------------------------------------------------