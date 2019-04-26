%% The Script for Training the Iris Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Iris_True_Path = 'C:\Users\shaya\Desktop\Attacks\Dataset\Original_True_Iris';
Iris_Fake_Path = 'C:\Users\shaya\Desktop\Attacks\Dataset\Original_Fake_Iris';

addpath('C:\Users\shaya\Desktop\Attacks\Iris');

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
        setimg = dir([Iris_True_Path,'\P',num2str(iy)]);
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

%% Using CNN for Feature Extraction and SVM for Classification
% Feature Extraction = Convolutional Neural Network
% Classifier = Support Vector Machine
net = alexnet();
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);
featureLayer = 'fc7';
trainingFeatures = activations(net,img_train, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

% Attack 1: Manipulation of the Labels
%mal_labels = img_train.Labels;
%ix = 1;
%while (ix <= (length(img_train.Labels)/4))
%    indx_1 = floor(512*rand()+1);
%    indx_2 = floor(512*rand()+1);
%    rand_1 = img_train.Labels(indx_1);
%    rand_2 = img_train.Labels(indx_2);
%    if (cellfun(@strcmp,rand_1,rand_2) == 0)
%        mal_labels(indx_1) = rand_2;
%        mal_labels(indx_2) = rand_1;
%        ix = ix + 1;
%    end
%end

figure();
subplot(2,1,1);
plot(find(strcmp(mal_labels,'True')),'-b','LineWidth',1.5);
hold on;
plot(find(strcmp(img_train.Labels,'True')),':k','LineWidth',1.5);
hold off;
ylabel(['Index in Label Array'], 'FontSize', 14);
xlabel('Index in True Array', 'FontSize', 14);
title('Comparison Between Actual and Manipulated True Labels', 'FontSize', 14);
AX=legend('Manipulated Labels','Acual Labels','Location','SouthEast');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',10);
set(gca, 'fontsize', 10);

subplot(2,1,2);
plot(find(strcmp(mal_labels,'Fake')),'-r','LineWidth',1.5);
hold on;
plot(find(strcmp(img_train.Labels,'Fake')),':k','LineWidth',1.5);
hold off;
ylabel(['Index in Label Array'], 'FontSize', 14);
xlabel('Index in Fake Array', 'FontSize', 14);
title('Comparison Between Actual and Manipulated Fake Labels', 'FontSize', 14);
AX=legend('Manipulated Labels','Acual Labels','Location','SouthEast');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',10);
set(gca, 'fontsize', 10);


classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

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