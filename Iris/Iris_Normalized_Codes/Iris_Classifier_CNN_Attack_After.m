%% The Script for Training the Iris Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Iris_True_Path = 'C:\Users\shaya\Desktop\Past_Works\Ongoing Works\Biometric_Work\Attacks\Dataset\Normalized_True_Iris';
Iris_Fake_Path = 'C:\Users\shaya\Desktop\Past_Works\Ongoing Works\Biometric_Work\Attacks\Dataset\Normalized_Fake_Iris';

addpath('C:\Users\shaya\Desktop\Attacks\Iris');

%% Getting Training Data
img_ix = 1; % The index of the vector of image files

% Getting True Iris Images
for iy = 1:85
    if (iy <= 9)
        setimg = dir([Iris_True_Path,'\U0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\U0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\U',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\U',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 1:85
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\U0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\U0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\U',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\U',num2str(iy),'\',setimg(iw).name];
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
        setimg = dir([Iris_True_Path,'\U0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\U0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_True_Path,'\U',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_True_Path,'\U',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'True';
            img_ix = img_ix + 1;
        end
    end
end

% Getting Fake Iris Images
for iy = 86:165
    if (iy <= 9)
        setimg = dir([Iris_Fake_Path,'\U0',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\U0',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    else
        setimg = dir([Iris_Fake_Path,'\U',num2str(iy)]);
        for iw = 3:6
            Img_Files{img_ix} = [Iris_Fake_Path,'\U',num2str(iy),'\',setimg(iw).name];
            Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
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
%mal_layers = net.Layers;

testFeatures = activations(net,img_test,featureLayer_test, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
testFeatures = testFeatures';
predictedLabels = predict(classifier, testFeatures);

%% Attacks on the System

%% Experiment 5
%i = 1;
%while (i <= length(mal_layers(20).Bias))
%    all_val = zeros(1,32);
%    for j = 1:32
%        all_val(j) = mal_layers(20).Bias(i+j-1);
%    end
%    for j = 1:32
%        mal_layers(20).Bias(i+j-1) = min(all_val);
%    end
%    i = i + 32;
%end

% Experiment 4:
%i = 1;
%while (i <= length(mal_layers(20).Bias))
%    sum_val = 0;
%    for j = 1:32
%        sum_val = sum_val + mal_layers(20).Bias(i+j-1);
%    end
%    ave_val = sum_val / 32;
%    for j = 1:32
%        mal_layers(20).Bias(i+j-1) = ave_val;
%    end
%    i = i + 32;
%end

% Experiment 3:
%i = 1;
%while (i <= length(mal_layers(20).Bias))
%   temp_1 = mal_layers(20).Bias(i);
%   temp_2 = mal_layers(20).Bias(i+1);
%   mal_layers(20).Bias(i) = temp_2;
%   mal_layers(20).Bias(i+1) = temp_1;
%   i = i + 2;
%end

% Changing the Weights

% Experiment 8
% flipud(mal_layers(20).Weights);

% Experiment 7
% mal_layers(20).Weights(:) = mean(mean(mal_layers(20).Weights));

% Experiment 7
% mal_layers(20).Weights(:) = median(median(mal_layers(20).Weights));

% Experiment 7
% mal_layers(20).Weights(:) = min(min(mal_layers(20).Weights));

% Experiment 7
% mal_layers(20).Weights(:) = mode(mode(mal_layers(20).Weights));

% Experiment 6
%for ix = 1:512:size(mal_layers(20).Weights,1)
%    for jx = 1:2:size(mal_layers(20).Weights,2)
%        temp_1 = mal_layers(20).Weights(jx,ix);
%        temp_2 = mal_layers(20).Weights(jx+1,ix);
%        mal_layers(20).Weights(jx,ix) = temp_2;
%        mal_layers(20).Weights(jx+1,ix) = temp_1;
%    end
%end

%mal_layers = mal_layers';
%netx = SeriesNetwork(mal_layers);

%% Experiment 2: Changing the Layer
%featureLayer_test = 'conv2';
%testFeatures = activations(netx,img_test,featureLayer_test,'MiniBatchSize',32);
%testFeatures = testFeatures';
%testFeatures = testFeatures(1:4096,:);
%testFeatures = testFeatures';

%testFeatures = activations(net,img_test,featureLayer_test,'MiniBatchSize',32);
%predictedLabels = predict(classifier, testFeatures);

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