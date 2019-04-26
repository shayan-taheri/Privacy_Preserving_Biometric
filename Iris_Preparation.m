% Written by Shayan Taheri
%% Read and Rename the Folders in Iris Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
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
    fprintf(dir_name);
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    set_dirL = dir([dir_name,'\L']);
    set_dirR = dir([dir_name,'\R']);
    if ((length(set_dirL) < 12) || (length(set_dirR) < 12))
        fprintf([dir_name,',']);
        rmdir(dir_name,'s');
    end
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
% Written by Shayan Taheri
%% Read and Rename the Folders in Iris Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fake_Iris';
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
    fprintf(dir_name);
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fake_Iris';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    if (length(dir(dir_name)) < 12)
        fprintf([dir_name,',']);
        rmdir(dir_name,'s');
    end
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
% Written by Shayan Taheri
%% Read and Rename the Folders in Iris Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
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
    fprintf(dir_name);
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    set_dirL = dir([dir_name,'\L']);
    set_dirR = dir([dir_name,'\R']);
    if ((length(set_dirL) < 12) || (length(set_dirR) < 12))
        fprintf([dir_name,',']);
        rmdir(dir_name,'s');
    end
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
% Written by Shayan Taheri
%% Read and Rename the Folders in Iris Dataset
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
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
    fprintf(dir_name);
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------
clear all; close all; clc;
Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris';
cd(Path);
addpath(Path);
set_dir = dir(Path);
N = length(set_dir);
for iz=3:N % The first two elements are extra
    dir_name = set_dir(iz).name;
    set_dirL = dir([dir_name,'\L']);
    set_dirR = dir([dir_name,'\R']);
    if ((length(set_dirL) < 12) || (length(set_dirR) < 12))
        fprintf([dir_name,',']);
        rmdir(dir_name,'s');
    end
    fprintf('\n');
end
% -------------------------------------------------------------------------------------------------------------------------------