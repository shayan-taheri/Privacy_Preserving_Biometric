%% The Script for Training the Iris Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Iris_True_Path = 'C:\users\shaya\Desktop\Attacks\Dataset\Original_True_Iris';
Iris_Fake_Path = 'C:\users\shaya\Desktop\Attacks\Dataset\Original_Fake_Iris';

addpath('C:\users\shaya\Desktop\Attacks\Iris');

%% Getting Training Data
img_ix = 1; % The index of the vector of image files

% Getting True Iris Images
for iy = 1:85
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\P',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 1:85
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\P0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\P',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\P',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
end

img_train = imageDatastore(Img_Files);
img_train.Labels = Labels;

%% Getting Testing Data

clear Img_Files;
clear Labels;
clear img_ix;

img_ix = 1; % The index of the vector of image files

% Getting True Iris Images
for iy = 86:165
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\P0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\P',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\P',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 86:165
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\P0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\P0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\P',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\P',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
end

img_test = imageDatastore(Img_Files);
img_test.Labels = Labels;


img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);
testFeatures = activations(net,img_test,featureLayer,'MiniBatchSize',32);
predictedLabels = predict(classifier, testFeatures);

% TP = A "True" is correctly recognized as "True".
% TN = A "Fake" is correctly recognized as "Fake".
% FP = A "Fake" is wrongly recognized as "True".
% FN = A "True" is wrongly recognized as "Fake".

TP = 0; TN = 0; FP = 0; FN = 0;
for iq = 1:length(predictedLabels)
    if (isequal(img_test.Labels(iq),{'True'}))
        if (isequal(predictedLabels(iq),{'True'}))
            TP = TP + 1;
        else
            FN = FN + 1;
        end
	else
        if (isequal(predictedLabels(iq),{'Fake'}))
            TN = TN + 1;
        else
            FP = FP + 1;
        end
    end
end

Perf_Data = [TP,FN;FP,TN]
Perf_Mat = [(TP/(TP+FN)),(FN/(FN+TP));(FP/(FP+TN)),(TN/(TN+FP))]
toc;