%%  The script for extracting the required data files for mask generation
% (1.A) Loading the binarized outputs of neurons for the right Iris
% (1.B) Loading the rank of the neurons based on their consistency
% (2) Generation of the data file for mask generation from the outputs of
%     a number of consistent neurons based on the right iris features
% (3.A) Loading the binarized and pruned outputs of neurons for the right thumb
% (3.B) Loading the rank of the neurons based on their consistency
% (4) Generation of the data file for mask generation from the outputs of
%     a number of consistent neurons based on the right thumb features

%% Processing the data

clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Milad_Data\Initial_Files');

% Choosing the best "50 Neurons of Iris" for mask generation!
iris_data = load('ri_171_bin.txt');
iris_check = load('ri_171_check.txt');
iris_check = iris_check';

[SortRank,SortIndex] = sort(iris_check,'ascend');

IrisMaskData = iris_data(:,SortIndex(1:50));

% Choosing the best "50 Neurons of Thumb" for mask generation!
thumb_data = load('rt_66_bin.txt');
thumb_check = load('rt_66_check.txt');
thumb_check = thumb_check';

[SortRank,SortIndex] = sort(thumb_check,'ascend');

ThumbMaskData = thumb_data(:,SortIndex(1:50));

save('C:\Users\shaya\Desktop\Milad_Data\DataForMask.mat','IrisMaskData','ThumbMaskData');
