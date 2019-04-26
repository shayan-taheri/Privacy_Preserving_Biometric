%% The Script for Training the Iris Biometric Data
%% Preparing Environment
clear all; close all; clc;
Iris_True_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Iris\True_Iris';
Iris_Fake_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Iris\Fake_Iris';

%% Getting Training Data
img_ix = 1; % The index of the vector of image files

% Getting True Left Iris Images
for iy = 1:20
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy),'\L']);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_True_Path,'\P0',num2str(iy),'\L\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy),'\L']);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_True_Path,'\P',num2str(iy),'\L\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting True Right Iris Images
for iy = 1:20
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy),'\R']);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_True_Path,'\P0',num2str(iy),'\R\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy),'\R']);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_True_Path,'\P',num2str(iy),'\R\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 1:40
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\P0',num2str(iy)]);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_Fake_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\P',num2str(iy)]);
        for iw = 3:12
            Img_Files{img_ix} = [Iris_Fake_Path,'\P',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
end

img_train = imageDatastore(Img_Files);
img_train.Labels = Labels;

%% Getting Testing Data
img_iy = 1; % The index of the vector of image files

% Getting True Left Iris Images
for iy = 21:30
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy),'\L']);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_True_Path,'\P0',num2str(iy),'\L\',setimg(iw).name];
            TestLB{img_iy} = 'True';
            img_iy = img_iy + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy),'\L']);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_True_Path,'\P',num2str(iy),'\L\',setimg(iw).name];
            TestLB{img_iy} = 'True';
            img_iy = img_iy + 1;
        end
    end
end

% Getting True Right Iris Images
for iy = 21:30
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy),'\R']);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_True_Path,'\P0',num2str(iy),'\R\',setimg(iw).name];
            TestLB{img_iy} = 'True';
            img_iy = img_iy + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy),'\R']);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_True_Path,'\P',num2str(iy),'\R\',setimg(iw).name];
            TestLB{img_iy} = 'True';
            img_iy = img_iy + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 41:100
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\P0',num2str(iy)]);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_Fake_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            TestLB{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\P',num2str(iy)]);
        for iw = 3:12
            Test_Files{img_iy} = [Iris_Fake_Path,'\P',num2str(iy),'\',setimg(iw).name];
            TestLB{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    end
end

img_test = imageDatastore(Test_Files);
img_test.Labels = TestLB;

addpath('C:\Users\shaya\Desktop\Milad Work');

%% Classification Process
% Feature Extraction = Bag of Features
% Classifier = Support Vector Machine
bag = bagOfFeaturesInfected(img_train);
categoryClassifier = trainImageCategoryClassifierInfected(img_train,bag);
confMatrix = evaluate(categoryClassifier,img_test)
mean(diag(confMatrix))

img_Test = 'C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Recognition System\Chosen Dataset\Iris\P01\L\I2_P01_Tst.jpg';
img = imread(img_Test);
[labelIdx, score] = predict(categoryClassifier,img)
categoryClassifier.Labels(labelIdx)