%% The Script for Classifying the Fingerprint Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Fing_With_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\With_Cooperation';
Fing_Without_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\Without_Cooperation';

%% Getting Training Data

% Train_Files --> The files for training
% Train_Labels --> The labels for training

img_ix = 1; % The index of the vector of image files

Fing_With_Dir = dir(Fing_With_Path);

for iq = 3:length(Fing_With_Dir)
    img_dir = Fing_With_Dir(iq);
    fake_path = [Fing_With_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_With_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'01') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'02'))
            Train_Files{img_ix} = [fake_path,'\',fake_imgs(iw).name];
            Train_Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'01') || strcmp(true_imgs(iw).name((end-5):(end-4)),'02'))
              Train_Files{img_ix} = [true_path,'\',true_imgs(iw).name];
              Train_Labels{img_ix} = 'True';
              img_ix = img_ix + 1;
          end
    end
end

Fing_Without_Dir = dir(Fing_Without_Path);

for iq = 3:length(Fing_Without_Dir)
    img_dir = Fing_Without_Dir(iq);
    fake_path = [Fing_Without_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_Without_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'01') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'02'))
            Train_Files{img_ix} = [fake_path,'\',fake_imgs(iw).name];
            Train_Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'01') || strcmp(true_imgs(iw).name((end-5):(end-4)),'02'))
              Train_Files{img_ix} = [true_path,'\',true_imgs(iw).name];
              Train_Labels{img_ix} = 'True';
              img_ix = img_ix + 1;
          end
    end
end

img_train = imageDatastore(Train_Files);
img_train.Labels = Train_Labels;

%% Getting Testing Data

% Test_Files --> The files for testing
% Test_Labels --> The labels for testing

img_iy = 1; % The index of the vector of image files

Fing_With_Dir = dir(Fing_With_Path);

for iq = 3:length(Fing_With_Dir)
    img_dir = Fing_With_Dir(iq);
    fake_path = [Fing_With_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_With_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'03') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'04'))
            Test_Files{img_iy} = [fake_path,'\',fake_imgs(iw).name];
            Test_Labels{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'03') || strcmp(true_imgs(iw).name((end-5):(end-4)),'04'))
              Test_Files{img_iy} = [true_path,'\',true_imgs(iw).name];
              Test_Labels{img_iy} = 'True';
              img_iy = img_iy + 1;
          end
    end
end

Fing_Without_Dir = dir(Fing_Without_Path);

for iq = 3:length(Fing_Without_Dir)
    img_dir = Fing_Without_Dir(iq);
    fake_path = [Fing_Without_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_Without_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'03') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'04'))
            Test_Files{img_iy} = [fake_path,'\',fake_imgs(iw).name];
            Test_Labels{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'03') || strcmp(true_imgs(iw).name((end-5):(end-4)),'04'))
              Test_Files{img_iy} = [true_path,'\',true_imgs(iw).name];
              Test_Labels{img_iy} = 'True';
              img_iy = img_iy + 1;
          end
    end
end

img_test = imageDatastore(Test_Files);
img_test.Labels = Test_Labels;

%% Using CNN for Feature Extraction and SVM for Classification
% Feature Extraction = Convolutional Neural Network
% Classifier = Support Vector Machine
net = alexnet();
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);
featureLayer = 'fc7';

% Infecting the training features
trainingFeatures = activations(net,img_train, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);

testFeatures = activations(net,img_test,featureLayer,'MiniBatchSize',32);

% Infecting the testing features

MaltestFeatures = testFeatures;

% Turn off random neurons
for ih = 1:size(MaltestFeatures,2)*(512/2)
    victim_neuron = floor(size(MaltestFeatures,2)*rand()+1);
    victim_image = floor(size(MaltestFeatures,1)*rand()+1);
    xc1 = 0; xc2 = 0;
    if ((rem(victim_neuron,2) == 0) && (rem(victim_image,2) ~= 0))
        MaltestFeatures(victim_image,victim_neuron) = abs(MaltestFeatures(victim_image,victim_neuron));
        xc1 = 1;
    end
    if ((rem(victim_neuron,2) ~= 0) && (rem(victim_image,2) == 0))
        MaltestFeatures(victim_image,victim_neuron) = -abs(MaltestFeatures(victim_image,victim_neuron));
        xc2 = 1;
    end
    if ((xc1 == 0) && (xc2 == 0))
        MaltestFeatures(victim_image,victim_neuron) = 0;
    end
end

%% OLD STUFF

% neuron_mean = round(mean(MalttestFeatures,1));
% neuron_median = round(median(trainingFeatures,2));
% neuron_mode = round(mode(trainingFeatures,2));

%ik = 1;
%pc = 1;
%while(length(neuron_median) ~= 0)
%   temp_indx = find(neuron_median==neuron_median(1));
%   eval(['Same.Ind_',num2str(ik),' = temp_indx;']);
%   neuron_median(temp_indx) = [];
%   pc = pc + 1;
%   ik = ik + 1;
%end

% Changing dissimilar neurons!
%for jb = 1:length(testFeatures)/2
%    SInd_1 = floor(length(fieldnames(Same))*rand()+1);
%    SInd_2 = floor(length(fieldnames(Same))*rand()+1);
%    RInd_1 = floor(eval(['length(Same.Ind_',num2str(SInd_1),')'])*rand()+1);
%    RInd_2 = floor(eval(['length(Same.Ind_',num2str(SInd_2),')'])*rand()+1);
%    eval(['Row_1 = Same.Ind_',num2str(SInd_1),'(',num2str(RInd_1),');']);
%    eval(['Row_2 = Same.Ind_',num2str(SInd_2),'(',num2str(RInd_2),');']);
%    MaltestFeatures(:,Row_2) = testFeatures(:,Row_1);
%    MaltestFeatures(:,Row_1) = testFeatures(:,Row_2);
%end

%histfit(Data)

%% Continuation of the Code Flow

predictedLabels = predict(classifier, MaltestFeatures);

% TP = A "True" is correctly recognized as "True".
% TN = A "Fake" is correctly recognized as "Fake".
% FP = A "Fake" is wrongly recognized as "True".
% FN = A "True" is wrognly recognized as "Fake".

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

Perf_Data = [TP,FN;FP,TN];
Perf_Mat = [(TP/(TP+FN)),(FN/(FN+TP));(FP/(FP+TN)),(TN/(TN+FP))];
toc;
