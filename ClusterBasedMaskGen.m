%% Processing the data

clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Milad_Data\Initial_Files');

% Choosing the best "50 Neurons of Thumb" for mask generation!
thumb_data = load('rt_66_bin.txt');

%% Maak Generation from Iris
% Generation of 165 Random Numbers
mask_array = randi([1e2 1e6],1,5);

% Choosing the best "50 Neurons of Iris" for mask generation!
iris_data = load('ri_171_bin.txt');

rng default; % For reproducibility
[idx_train,C] = kmeans(iris_data(1:425,:),5);

idx_test = kmeans(iris_data(426:825,:),5,'Start',C);

TrainUsersMasks = zeros(size(idx_train,1)/5,5);
for idd = 1:size(idx_train,1)/5
    TrainUsersMasks(idd,:) = [mask_array(idx_train((idd-1)*5+1)), ...
        mask_array(idx_train((idd-1)*5+2)),mask_array(idx_train((idd-1)*5+3)), ...
        mask_array(idx_train((idd-1)*5+4)),mask_array(idx_train((idd-1)*5+5))];
end

TestUsersMasks = zeros(size(idx_test,1)/5,5);
for idd = 1:size(idx_test,1)/5
    TestUsersMasks(idd,:) = [mask_array(idx_test((idd-1)*5+1)), ...
        mask_array(idx_test((idd-1)*5+2)),mask_array(idx_test((idd-1)*5+3)), ...
        mask_array(idx_test((idd-1)*5+4)),mask_array(idx_test((idd-1)*5+5))];
end

for iff = 1:size(TrainUsersMasks,1)/10
    fig = figure();
    bar((iff-1)*10+1:(iff-1)*10+1+9,TrainUsersMasks((iff-1)*10+1:(iff-1)*10+1+9,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Iris Data for Mask Generation (Training) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Iris_Cluster\Train_',num2str(iff),'.pdf']);
end

fig = figure();
bar(81:85,TrainUsersMasks(81:85,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title(['Analysis of Iris Data for Mask Generation (Training) -- ',num2str(9)],'FontSize',14);
saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Iris_Cluster\Train_',num2str(9),'.pdf']);

for iff = 1:size(TestUsersMasks,1)/10
    fig = figure();
    bar((iff-1)*10+1+85:(iff-1)*10+1+9+85,TestUsersMasks((iff-1)*10+1:(iff-1)*10+1+9,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Iris Data for Mask Generation (Testing) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Iris_Cluster\Test_',num2str(iff),'.pdf']);
end

save('C:\Users\shaya\Desktop\Milad_Data\Cluster_Masks\IrisClusterMasks.mat','TrainUsersMasks','TestUsersMasks');

%% Maak Generation from Thumb
% Generation of 165 Random Numbers
mask_array = randi([1e2 1e6],1,5);

% Choosing the best "50 Neurons of Thumb" for mask generation!
thumb_data = load('rt_66_bin.txt');

rng default; % For reproducibility
[idx_train,C] = kmeans(thumb_data(1:425,:),5);

idx_test = kmeans(thumb_data(426:825,:),5,'Start',C);

TrainUsersMasks = zeros(size(idx_train,1)/5,5);
for idd = 1:size(idx_train,1)/5
    TrainUsersMasks(idd,:) = [mask_array(idx_train((idd-1)*5+1)), ...
        mask_array(idx_train((idd-1)*5+2)),mask_array(idx_train((idd-1)*5+3)), ...
        mask_array(idx_train((idd-1)*5+4)),mask_array(idx_train((idd-1)*5+5))];
end

TestUsersMasks = zeros(size(idx_test,1)/5,5);
for idd = 1:size(idx_test,1)/5
    TestUsersMasks(idd,:) = [mask_array(idx_test((idd-1)*5+1)), ...
        mask_array(idx_test((idd-1)*5+2)),mask_array(idx_test((idd-1)*5+3)), ...
        mask_array(idx_test((idd-1)*5+4)),mask_array(idx_test((idd-1)*5+5))];
end

for iff = 1:size(TrainUsersMasks,1)/10
    fig = figure();
    bar((iff-1)*10+1:(iff-1)*10+1+9,TrainUsersMasks((iff-1)*10+1:(iff-1)*10+1+9,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Thumb Data for Mask Generation (Training) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Thumb_Cluster\Train_',num2str(iff),'.pdf']);
end

fig = figure();
bar(81:85,TrainUsersMasks(81:85,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title(['Analysis of Thumb Data for Mask Generation (Training) -- ',num2str(9)],'FontSize',14);
saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Thumb_Cluster\Train_',num2str(9),'.pdf']);

for iff = 1:size(TestUsersMasks,1)/10
    fig = figure();
    bar((iff-1)*10+1+85:(iff-1)*10+1+9+85,TestUsersMasks((iff-1)*10+1:(iff-1)*10+1+9,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Thumb Data for Mask Generation (Testing) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Thumb_Cluster\Test_',num2str(iff),'.pdf']);
end

save('C:\Users\shaya\Desktop\Milad_Data\Cluster_Masks\ThumbClusterMasks.mat','TrainUsersMasks','TestUsersMasks');
