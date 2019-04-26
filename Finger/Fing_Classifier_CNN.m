%% The Script for Training the Fingerprint Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Fing_True_Path = 'C:\users\shaya\Desktop\Attacks\Dataset\Original_True_Fing';
Fing_Fake_Path = 'C:\users\shaya\Desktop\Attacks\Dataset\Original_Fake_Fing';

addpath('C:\users\shaya\Desktop\Attacks\Finger');

%% Getting Training Data
img_ix = 1; % The index of the vector of image files

% Getting True Fingerprint Images
for iy = 3:(85*5+3-1)
    setimg = dir(Fing_True_Path);
    Img_Files{img_ix} = [Fing_True_Path,'\',setimg(iy).name];
    Labels{img_ix} = 'True';
    img_ix = img_ix + 1;
end

% Getting Fake Fingerprint Images
for iy = 3:(136+3-1)
    setimg = dir(Fing_Fake_Path);
    Img_Files{img_ix} = [Fing_Fake_Path,'\',setimg(iy).name];
    Labels{img_ix} = 'Fake';
    img_ix = img_ix + 1;
end

img_train = imageDatastore(Img_Files);
img_train.Labels = Labels;

%% Getting Testing Data

clear Img_Files;
clear Labels;
clear img_ix;

img_ix = 1; % The index of the vector of image files

% Getting True Fingerprint Images
for iy = (85*5+3-1+1):(165*5+3-1)
    setimg = dir(Fing_True_Path);
    Img_Files{img_ix} = [Fing_True_Path,'\',setimg(iy).name];
    Labels{img_ix} = 'True';
    img_ix = img_ix + 1;
end

% Getting Fake Fingerprint Images
for iy = (136+3-1+1):(272+3-1)
    setimg = dir(Fing_Fake_Path);
    Img_Files{img_ix} = [Fing_Fake_Path,'\',setimg(iy).name];
    Labels{img_ix} = 'Fake';
    img_ix = img_ix + 1;
end

img_test = imageDatastore(Img_Files);
img_test.Labels = Labels;

%% Using CNN for Feature Extraction and SVM for Classification
% Feature Extraction = Convolutional Neural Network
% Classifier = Support Vector Machinenet = alexnet();
net = alexnet();
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);
featureLayer_train = 'fc7';
trainingFeatures = activations(net,img_train, featureLayer_train, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

featureLayer_test = 'fc7';
img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);
mal_layers = net.Layers;

mal_layers = mal_layers';
netx = SeriesNetwork(mal_layers);

testFeatures = activations(netx,img_test,featureLayer_test,'MiniBatchSize',32);
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