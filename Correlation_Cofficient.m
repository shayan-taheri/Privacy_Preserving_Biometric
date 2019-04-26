%% The script for graphical illustration of correlation coefficient
%% Between the True and Fake Fingerprints and Irises
clear all; close all; clc;

% True Fingerprint (1)
TF1 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-FingerprintV5 (000-099)\000\L\000_L0_0.bmp');
Img(1,:,:) = imresize(TF1,[560 400]);
Label(1) = {'TF1'};

% True Fingerprint (2)
TF2 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-FingerprintV5 (000-099)\000\L\000_L0_1.bmp');
Img(2,:,:) = imresize(TF2,[560 400]);
Label(2) = {'TF2'};

% True Fingerprint (3)
TF3 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-FingerprintV5 (000-099)\000\L\000_L0_2.bmp');
Img(3,:,:) = imresize(TF3,[560 400]);
Label(3) = {'TF3'};

% True Fingerprint (4)
TF4 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-FingerprintV5 (000-099)\000\L\000_L0_3.bmp');
Img(4,:,:) = imresize(TF4,[560 400]);
Label(4) = {'TF4'};

% True Fingerprint (5)
TF5 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-FingerprintV5 (000-099)\000\L\000_L0_4.bmp');
Img(5,:,:) = imresize(TF5,[560 400]);
Label(5) = {'TF5'};

% Fake Fingerprint (1)
FF1 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation\u01\fake\u01_f_fo_li_01.bmp');
Img(6,:,:) = imresize(FF1,[560 400]);
Label(6) = {'FF1'};

% Fake Fingerprint (2)
FF2 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation\u01\fake\u01_f_fo_li_01.bmp');
Img(7,:,:) = imresize(FF2,[560 400]);
Label(7) = {'FF2'};

% Fake Fingerprint (3)
FF3 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation\u01\fake\u01_f_fo_li_03.bmp');
Img(8,:,:) = imresize(FF3,[560 400]);
Label(8) = {'FF3'};

% Fake Fingerprint (4)
FF4 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation\u01\fake\u01_f_fo_li_04.bmp');
Img(9,:,:) = imresize(FF4,[560 400]);
Label(9) = {'FF4'};

% Fake Fingerprint (5)
FF5 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\ATVS-FFp_DB\DS_WithCooperation\u01\fake\u01_f_fo_lm_01.bmp');
Img(10,:,:) = imresize(FF5,[560 400]);
Label(10) = {'FF5'};

% True Iris (1)
TI1 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Interval\001\L\S1001L01.jpg');
Img(11,:,:) = imresize(TI1,[560 400]);
Label(11) = {'TI1'};

% True Iris (2)
TI2 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Interval\001\L\S1001L02.jpg');
Img(12,:,:) = imresize(TI2,[560 400]);
Label(12) = {'TI2'};

% True Iris (3)
TI3 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Interval\001\L\S1001L03.jpg');
Img(13,:,:) = imresize(TI3,[560 400]);
Label(13) = {'TI3'};

% True Iris (4)
TI4 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Interval\001\L\S1001L04.jpg');
Img(14,:,:) = imresize(TI4,[560 400]);
Label(14) = {'TI4'};

% True Iris (5)
TI5 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Interval\001\L\S1001L05.jpg');
Img(15,:,:) = imresize(TI5,[560 400]);
Label(15) = {'TI5'};

% Fake Iris (1)
FI1 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Syn\000\S6000S00.jpg');
Img(16,:,:) = imresize(FI1,[560 400]);
Label(16) = {'FI1'};

% Fake Iris (2)
FI2 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Syn\000\S6000S01.jpg');
Img(17,:,:) = imresize(FI2,[560 400]);
Label(17) = {'FI2'};

% Fake Iris (3)
FI3 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Syn\000\S6000S02.jpg');
Img(18,:,:) = imresize(FI3,[560 400]);
Label(18) = {'FI3'};

% Fake Iris (4)
FI4 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Syn\000\S6000S03.jpg');
Img(19,:,:) = imresize(FI4,[560 400]);
Label(19) = {'FI4'};

% Fake Iris (5)
FI5 = imread('C:\Users\shaya\Desktop\Recognition Hardware Security\Recognition System Modules\Datasets\CASIA-Iris-Syn\000\S6000S04.jpg');
Img(20,:,:) = imresize(FI5,[560 400]);
Label(20) = {'FI5'};

Matrix = zeros(20,20);

for ix = 1:20
    for iy = 1:20
        Test = Img(ix,:,:);
        Temp = corrcoef(double(Test),double(Img(iy,:,:)));
        Corr_Val = Temp(1,2);
        Matrix(ix,iy) = Corr_Val;
    end
end

% M = Matrix of Correlation Coefficients;
% L = Vector of Labels;
imagesc(Matrix); % Plot the matrix
set(gca,'XTick',1:20); % Center X-axis ticks on bins
set(gca,'YTick',1:20); % Center Y-axis ticks on bins
set(gca,'XTickLabel',Label); % Set X-axis labels
set(gca,'YTickLabel',Label); % Set Y-axis labels
title('Relationship Among Biometric Data','FontSize',14); % Graph Title
colormap('jet');
colorbar;

