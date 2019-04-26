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

%% Using CNN for Feature Extraction and SVM for Classification
% Feature Extraction = Convolutional Neural Network
% Classifier = Support Vector Machine
net = alexnet();
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);
featureLayer = 'fc7';
trainingFeatures = activations(net,img_train, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);
testFeatures = activations(net,img_test,featureLayer,'MiniBatchSize',32);
predictedLabels = predict(classifier, testFeatures);
confMat = confusionmat(img_test.Labels, predictedLabels);
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
mean(diag(confMat))
img_Test = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Iris\Fake_Iris\P78\S6077S07.jpg';
img = readAndPreprocessImage(img_Test);
imageFeatures = activations(net,img,featureLayer);
label = predict(classifier, imageFeatures)



