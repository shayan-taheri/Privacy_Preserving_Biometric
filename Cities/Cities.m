%% The script for: the CSV Data --> String Arrays
% Data Source: https://en.wikipedia.org/wiki/List_of_largest_cities
clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Milad Work\Word Features\Cities');

[num,txt,raw] = xlsread('C:\Users\shaya\Desktop\Milad Work\Word Features\Cities\WikiCities.xlsx');

CityCountry = txt;

for ixx = 1:size(CityCountry,1)
    clear Temp_New;
    iyy = 2;
    Temp = CityCountry{ixx,iyy};
    for izz = 2:length(Temp)
      Temp_New(izz-1) = Temp(izz);
    end
    CityCountryUpdate{ixx,iyy} = Temp_New;
end

for ixx = 1:size(CityCountry,1)
    clear Temp_New;
    iyy = 1;
    Temp = CityCountry{ixx,iyy};
    CityCountryUpdate{ixx,iyy} = Temp;
end

save('C:\Users\shaya\Desktop\Milad Work\Word Features\Cities\BirthPlace.mat','CityCountryUpdate');