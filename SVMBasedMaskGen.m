%% The Script for Generating Mask Using Support Vector Machine (SVM)
%% Preparing Environment
clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Milad_Data\Initial_Files');
addpath('C:\Users\shaya\Desktop\Milad_Data');
iris_data = load('ri_171_bin_pruned.txt');

%% Training Data for Mask Generation from Iris

% Generation of 165 Random Numbers
mask_array = randi([1e2 1e6],1,165);

iris_ix = 1;

% Number of Training Features = 165 * 3
for iq = 1:size(iris_data,1)/5
	for iw = 1:3
        Train_Features(iris_ix,:) = iris_data((iq-1)*5+iw,:);
        Train_Labels(iris_ix) = mask_array(iq);
        iris_ix = iris_ix + 1;
	end
end

Train_Features = Train_Features';
Train_Labels = Train_Labels';

%% Testing Data for Mask Generation from Iris

iris_ix = 1;

% Number of Testing Features = 165 * 2
for iq = 1:size(iris_data,1)/5
	for iw = 4:5
        Test_Features(iris_ix,:) = iris_data((iq-1)*5+iw,:);
        Actual_Labels(iris_ix) = mask_array(iq);
        iris_ix = iris_ix + 1;
	end
end

%% Generation of Iris Mask Using SVM
classifier = fitcecoc(Train_Features,Train_Labels, ...
    'Learners','svm','Coding','allpairs','ObservationsIn','columns');

Test_Labels = predict(classifier, Test_Features);

for icc = 1:length(Train_Labels)/3
   TrainLabelsPlot(icc,1:3) = Train_Labels((icc-1)*3+1:(icc-1)*3+1+2);
end

for icc = 1:length(Test_Labels)/2
   TestLabelsPlot(icc,1:2) = Test_Labels((icc-1)*2+1:(icc-1)*2+1+1);
end

Actual_Labels = Actual_Labels';
ErrorUser = zeros(size(Test_Labels,1)/2,1);
for itt = 1:size(Test_Labels,1)
    if (Test_Labels(itt) ~= Actual_Labels(itt))
        ErrorUser(ceil(itt/2)) = 1;
    end
end

fig = figure();
bar(ErrorUser);
barvalues;
xlabel('User Index','FontSize',14);
ylabel('Error = 1','FontSize',14);
yyaxis right;
set(gca,'yscale','log','YTick',[0.00001 0.00002 0.0001 0.0002:0.0002:0.001 0.002:002:0.01 0.015 0.02:0.01:0.05]);
ylabel('Analysis of Users with Unstable Iris Masks','FontSize',14,'Color','k');
saveas(fig,'C:\Users\shaya\Desktop\Milad_Data\Iris_Results\Error.pdf');

for iff = 1:size(TrainLabelsPlot,1)/20
    fig = figure();
    bar((iff-1)*20+1:(iff-1)*20+1+19,TrainLabelsPlot((iff-1)*20+1:(iff-1)*20+1+19,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Iris Data for Mask Generation (Training) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Iris_Results\Train_',num2str(iff),'.pdf']);
    
    fig = figure();
    bar((iff-1)*20+1:(iff-1)*20+1+19,TestLabelsPlot((iff-1)*20+1:(iff-1)*20+1+19,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Iris Data for Mask Generation (Testing) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Iris_Results\Test_',num2str(iff),'.pdf']);
end

TrainUsersLabels = TrainLabelsPlot;
TestUsersLabels = TestLabelsPlot;

save('C:\Users\shaya\Desktop\Milad_Data\SVM_Masks\IrisSVMMasks.mat','TrainUsersLabels','TestUsersLabels','ErrorUser');

%% Preparing Environment
clear all; close all; clc;

addpath('C:\Users\shaya\Desktop\Milad_Data\Initial_Files');
addpath('C:\Users\shaya\Desktop\Milad_Data');
thumb_data = load('rt_66_bin_pruned.txt');

%% Training Data for Mask Generation from Thumb

% Generation of 165 Random Numbers
mask_array = randi([1e2 1e6],1,165);

thumb_ix = 1;

% Number of Training Features = 165 * 3
for iq = 1:size(thumb_data,1)/5
	for iw = 1:3
        Train_Features(thumb_ix,:) = thumb_data((iq-1)*5+iw,:);
        Train_Labels(thumb_ix) = mask_array(iq);
        thumb_ix = thumb_ix + 1;
	end
end

Train_Features = Train_Features';
Train_Labels = Train_Labels';

%% Testing Data for Mask Generation from Thumb

thumb_ix = 1;

% Number of Testing Features = 165 * 2
for iq = 1:size(thumb_data,1)/5
	for iw = 4:5
        Test_Features(thumb_ix,:) = thumb_data((iq-1)*5+iw,:);
        Actual_Labels(thumb_ix) = mask_array(iq);
        thumb_ix = thumb_ix + 1;
	end
end

%% Generation of Thumb Mask Using SVM
classifier = fitcecoc(Train_Features,Train_Labels, ...
    'Learners','svm','Coding','allpairs','ObservationsIn','columns');

Test_Labels = predict(classifier, Test_Features);

for icc = 1:length(Train_Labels)/3
   TrainLabelsPlot(icc,1:3) = Train_Labels((icc-1)*3+1:(icc-1)*3+1+2);
end

for icc = 1:length(Test_Labels)/2
   TestLabelsPlot(icc,1:2) = Test_Labels((icc-1)*2+1:(icc-1)*2+1+1);
end

Actual_Labels = Actual_Labels';
ErrorUser = zeros(size(Test_Labels,1)/2,1);
for itt = 1:size(Test_Labels,1)
    if (Test_Labels(itt) ~= Actual_Labels(itt))
        ErrorUser(ceil(itt/2)) = 1;
    end
end

fig = figure();
bar(ErrorUser,0.1);
barvalues;
xlabel('User Index','FontSize',14);
ylabel('Error = 1','FontSize',14);
yyaxis right;
set(gca,'yscale','log','YTick',[0.00001 0.00002 0.0001 0.0002:0.0002:0.001 0.002:002:0.01 0.015 0.02:0.01:0.05]);
ylabel('Analysis of Users with Unstable Thumb Masks','FontSize',14,'Color','k');
saveas(fig,'C:\Users\shaya\Desktop\Milad_Data\Thumb_Results\Error.pdf');

for iff = 1:size(TrainLabelsPlot,1)/20
    fig = figure();
    bar((iff-1)*20+1:(iff-1)*20+1+19,TrainLabelsPlot((iff-1)*20+1:(iff-1)*20+1+19,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Thumb Data for Mask Generation (Training) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Thumb_Results\Train_',num2str(iff),'.pdf']);
    
    fig = figure();
    bar((iff-1)*20+1:(iff-1)*20+1+19,TestLabelsPlot((iff-1)*20+1:(iff-1)*20+1+19,:),'group');
    xlabel('User Index','FontSize',14);
    ylabel('Mask Value','FontSize',14);
    title(['Analysis of Thumb Data for Mask Generation (Testing) -- ',num2str(iff)],'FontSize',14);
    saveas(fig,['C:\Users\shaya\Desktop\Milad_Data\Thumb_Results\Test_',num2str(iff),'.pdf']);
end

TrainUsersLabels = TrainLabelsPlot;
TestUsersLabels = TestLabelsPlot;

save('C:\Users\shaya\Desktop\Milad_Data\SVM_Masks\ThumbSVMMasks.mat','TrainUsersLabels','TestUsersLabels');
