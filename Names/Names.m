%% The script for: the CSV Data --> String Arrays
% Data Source: https://gist.github.com/mbejda/26ad0574eda7fca78573
clear all; close all; clc;

BlackFemaleNames = readtable('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\Black-Female-Names.csv');
BlackMaleNames = readtable('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\Black-Male-Names.csv');
WhiteFemaleNames = readtable('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\White-Female-Names.csv');
WhiteMaleNames = readtable('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\White-Male-Names.csv');

BlackFemaleNames = BlackFemaleNames(:,1:2);

for ixx = 1:size(BlackFemaleNames,1)
    for iyy = 1:size(BlackFemaleNames,2)
       BlackFemales{ixx,iyy} = {char(table2array(BlackFemaleNames(ixx,iyy)))};
    end
end

for ixx = 1:165
        clear Temp;
        clear Temp_New;
        ikk = 1;
        Temp = strcat(num2str(cell2mat(BlackFemales{ixx,1})),num2str(cell2mat(BlackFemales{ixx,2})));
        for izz = 1:length(Temp)
            if (~((Temp(izz) == ' ') || (Temp(izz) == ',')))
               Temp_New(ikk) = Temp(izz);
               ikk = ikk + 1;
            end
        end
        BlackFemalesOut{ixx} = Temp_New;
end

BlackFemalesOut = BlackFemalesOut';

BlackMaleNames = BlackMaleNames(:,1:2);

for ixx = 1:size(BlackMaleNames,1)
    for iyy = 1:size(BlackMaleNames,2)
       BlackMales{ixx,iyy} = {char(table2array(BlackMaleNames(ixx,iyy)))};
    end
end

for ixx = 1:165
        clear Temp;
        clear Temp_New;
        ikk = 1;
        Temp = strcat(num2str(cell2mat(BlackMales{ixx,1})),num2str(cell2mat(BlackMales{ixx,2})));
        for izz = 1:length(Temp)
            if (~((Temp(izz) == ' ') || (Temp(izz) == ',')))
               Temp_New(ikk) = Temp(izz);
               ikk = ikk + 1;
            end
        end
        BlackMalesOut{ixx} = Temp_New;
end

BlackMalesOut = BlackMalesOut';

WhiteFemaleNames = WhiteFemaleNames(:,1:2);

for ixx = 1:size(WhiteFemaleNames,1)
    for iyy = 1:size(WhiteFemaleNames,2)
       WhiteFemales{ixx,iyy} = {char(table2array(WhiteFemaleNames(ixx,iyy)))};
    end
end

for ixx = 1:165
        clear Temp;
        clear Temp_New;
        ikk = 1;
        Temp = strcat(num2str(cell2mat(WhiteFemales{ixx,1})),num2str(cell2mat(WhiteFemales{ixx,2})));
        for izz = 1:length(Temp)
            if (~((Temp(izz) == ' ') || (Temp(izz) == ',')))
               Temp_New(ikk) = Temp(izz);
               ikk = ikk + 1;
            end
        end
        WhiteFemalesOut{ixx} = Temp_New;
end

WhiteFemalesOut = WhiteFemalesOut';

WhiteMaleNames = WhiteMaleNames(:,1:2);

for ixx = 1:size(WhiteMaleNames,1)
    for iyy = 1:size(WhiteMaleNames,2)
       WhiteMales{ixx,iyy} = {char(table2array(WhiteMaleNames(ixx,iyy)))};
    end
end

for ixx = 1:165
        ikk = 1;
        clear Temp;
        clear Temp_New;
        Temp = strcat(num2str(cell2mat(WhiteMales{ixx,1})),num2str(cell2mat(WhiteMales{ixx,2})));
        for izz = 1:length(Temp)
            if (~((Temp(izz) == ' ') || (Temp(izz) == ',')))
               Temp_New(ikk) = Temp(izz);
               ikk = ikk + 1;
            end
        end
        WhiteMalesOut{ixx} = Temp_New;
end

WhiteMalesOut = WhiteMalesOut';

save('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\UserNameData.mat','BlackFemalesOut','BlackMalesOut','WhiteFemalesOut','WhiteMalesOut');
