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
% Classifier = Support Vector Machinenet = alexnet();
net = alexnet();
mal_layers = net.Layers;
mal_layers = mal_layers';
netx = SeriesNetwork(mal_layers);

featureLayer = 'fc7';
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);

img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);

%% Experiment 11: Changing the Bias Parameter
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

% Experiment 12
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

% Experiment 10
%i = 1;
%while (i <= length(mal_layers(20).Bias))
%   temp_1 = mal_layers(20).Bias(i);
%   temp_2 = mal_layers(20).Bias(i+1);
%   mal_layers(20).Bias(i) = temp_2;
%   mal_layers(20).Bias(i+1) = temp_1;
%   i = i + 2;
%end

%% Changing the Weights

% Experiment 15
%flipud(mal_layers(20).Weights);

% Experiment 14
% mal_layers(20).Weights(:) = mean(mean(mal_layers(20).Weights));

% Experiment 14
% mal_layers(20).Weights(:) = median(median(mal_layers(20).Weights));

% Experiment 14
% mal_layers(20).Weights(:) = min(min(mal_layers(20).Weights));

% Experiment 14
% mal_layers(20).Weights(:) = mode(mode(mal_layers(20).Weights));

% Experiment 13
%for ix = 1:512:size(mal_layers(20).Weights,1)
%    for jx = 1:2:size(mal_layers(20).Weights,2)
%        temp_1 = mal_layers(20).Weights(jx,ix);
%        temp_2 = mal_layers(20).Weights(jx+1,ix);
%        mal_layers(20).Weights(jx,ix) = temp_2;
%        mal_layers(20).Weights(jx+1,ix) = temp_1;
%    end
%end

%% Experiment 9: Changing the Layer
% featureLayer = 'conv2';

trainingFeatures = activations(netx,img_train, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

testFeatures = activations(netx,img_test,featureLayer,'MiniBatchSize',32);
predictedLabels = predict(classifier, testFeatures);

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