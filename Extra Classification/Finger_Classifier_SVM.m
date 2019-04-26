%% The Script for Classifying the Fingerprint Biometric Data
%% Preparing Environment
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

addpath('C:\Users\shaya\Desktop\Milad Work');

%% Classification Process
% Feature Extraction = Bag of Features
% Classifier = Support Vector Machine
bag = bagOfFeaturesInfected(img_train);
categoryClassifier = trainImageCategoryClassifierInfected(img_train,bag);
confMatrix = evaluate(categoryClassifier,img_test)
mean(diag(confMatrix))

img_Test = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\Extra_Test\True_04\004_L0_2.jpg';
img = imread(img_Test);
[labelIdx, score] = predict(categoryClassifier,img)
categoryClassifier.Labels(labelIdx)