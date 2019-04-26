%% The Script for True/Fake Assessment of Iris Data
%% Preparing Environment
clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Attacks\Initial_Files');
addpath('C:\Users\shaya\Desktop\Attacks');
iris_true_data = load('ri_171_bin_pruned.txt');
iris_fake_data = load('???');

%% Training Data for True/Fake Assessment of Iris Data

iris_ix = 1;

% Number of Training Features = 165 * 3
for iq = 1:size(iris_true_data,1)/5
	for iw = 1:3
        Train_Features(iris_ix,:) = iris_true_data((iq-1)*5+iw,:);
        Train_Labels(iris_ix) = 'True';
        iris_ix = iris_ix + 1;
	end
end

for iq = 1:size(iris_fake_data,1)/5
	for iw = 1:3
        Train_Features(iris_ix,:) = iris_fake_data((iq-1)*5+iw,:);
        Train_Labels(iris_ix) = 'Fake';
        iris_ix = iris_ix + 1;
	end
end

Train_Features = Train_Features';
Train_Labels = Train_Labels';

%% Testing Data for True/Fake Assessment of Iris Data

iris_ix = 1;

% Number of Testing Features = 165 * 2
for iq = 1:size(iris_true_data,1)/5
	for iw = 4:5
        Test_Features(iris_ix,:) = iris_true_data((iq-1)*5+iw,:);
        Actual_Labels(iris_ix) = 'True';
        iris_ix = iris_ix + 1;
	end
end

% Number of Testing Features = 165 * 2
for iq = 1:size(iris_fake_data,1)/5
	for iw = 4:5
        Test_Features(iris_ix,:) = iris_fake_data((iq-1)*5+iw,:);
        Actual_Labels(iris_ix) = 'Fake';
        iris_ix = iris_ix + 1;
	end
end

%% Generation of Iris Mask Using SVM
classifier = fitcecoc(Train_Features,Train_Labels, ...
    'Learners','svm','Coding','allpairs','ObservationsIn','columns');

Test_Labels = predict(classifier, Test_Features);

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
            FP = FP + 1;
        end
	else
        if (isequal(predictedLabels(iq),{'Fake'}))
            TN = TN + 1;
        else
            FN = FN + 1;
        end
    end
end

% Actual (Vertical) Vs. Predicted (Horizontal)
Perf_Data = [TP,FN;FP,TN];
Perf_Mat = [(TP/(TP+FN)),(FN/(FN+TP));(FP/(FP+TN)),(TN/(TN+FP))];
