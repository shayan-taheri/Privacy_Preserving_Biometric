%% The script for extracting features from Username and Birth Place
clear all; close all; clc;

load('C:\Users\shaya\Desktop\Milad Work\Word Features\Cities\BirthPlace.mat');
load('C:\Users\shaya\Desktop\Milad Work\Word Features\Names\UserNameData.mat');
addpath('C:\Users\shaya\Desktop\Milad Work\Word Features');

English_Alphabets_UC = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N', ...
    'O','P','Q','R','S','T','U','V','W','X','Y','Z'];

English_Alphabets_LC = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n', ...
    'o','p','q','r','s','t','u','v','w','x','y','z'];

NameMatrix = [BlackFemalesOut';BlackMalesOut';WhiteFemalesOut';WhiteMalesOut'];

% UserArrayClass.User;
% UserArrayClass.Place;
% UserArrayClass.UserFeature
% UserArrayClass.PlaceFeature

for indx = 1:165
    
    NameRow = floor(rand()*size(NameMatrix,1))+1;
    NameCol = floor(rand()*size(NameMatrix,2))+1;
    
    StringUser = char(NameMatrix(NameRow,NameCol));
    clear StringUserUpdate;
    izz = 1;
    for ivv = 1:length(StringUser)
        issue = 1;
        for irr = 1:length(English_Alphabets_UC)
            if ((StringUser(ivv) == English_Alphabets_LC(irr)) || (StringUser(ivv) == English_Alphabets_UC(irr)))
               issue = 0; 
            end
        end
        if (issue == 0)
           StringUserUpdate(izz) = StringUser(ivv);
           izz = izz + 1;
        end
    end
    
    UserArrayClass(indx).User = StringUserUpdate;
    
    CityIndx = floor(rand()*size(CityCountryUpdate,1))+1;
    
    StringPlace = strcat(char(CityCountryUpdate(CityIndx,1)),char(CityCountryUpdate(CityIndx,2)));

    clear StringPlace_New;
    icv = 1;
    for izv = 1:length(StringPlace)
    	if (~((StringPlace(izv) == ' ') || (StringPlace(izv) == ' ') || (StringPlace(izv) == ',')))
            StringPlace_New(icv) = StringPlace(izv);
            icv = icv + 1;
     	end
    end
    
    StringPlace = StringPlace_New;
    
    clear StringPlaceUpdate;
    izz = 1;
    for ivv = 1:length(StringPlace_New)
        issue = 1;
        for irr = 1:length(English_Alphabets_UC)
            if ((StringPlace_New(ivv) == English_Alphabets_LC(irr)) || (StringPlace_New(ivv) == English_Alphabets_UC(irr)))
               issue = 0; 
            end
        end
        if (issue == 0)
           StringPlaceUpdate(izz) = StringPlace_New(ivv);
           izz = izz + 1;
        end
    end
    
    UserArrayClass(indx).Place = StringPlaceUpdate;
    
    UserArrayClass(indx).UserFeature = m1_word_feature(UserArrayClass(indx).User);
    UserArrayClass(indx).PlaceFeature = m2_word_feature(UserArrayClass(indx).Place);
end

save('C:\Users\shaya\Desktop\Milad Work\Word Features\UserFeatures.mat','UserArrayClass');
