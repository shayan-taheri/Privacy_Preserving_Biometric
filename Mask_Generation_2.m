%% The Script for Generation of the Biometric Part of Mask
%% Preparing Environment
clear all; close all; clc;

load('C:\Users\shaya\Desktop\Milad_Data\DataForMask.mat');

%% Analysis of Iris Data

IrisMaskData = IrisMaskData(:,1:50);

IrisInitialValues = zeros(length(IrisMaskData),1);
for iw = 1:size(IrisMaskData,1)
    for in = 1:50
        IrisInitialValues(iw) = IrisInitialValues(iw) + IrisMaskData(iw,in)*2^((51-in)-1);
    end
    IrisInitialValues(iw) = roundn(IrisInitialValues(iw),1);
end

IrisInitialValues = IrisInitialValues / 10^15;

% Calculation of the Majority Vote
IrisMajorityData = zeros(size(IrisMaskData,1),size(IrisMaskData,2)/5);
for ix = 1:size(IrisMaskData,1)
    for iy = 1:size(IrisMaskData,2)/5
        one_cnt = 0; % Number of ones
        zero_cnt = 0; % Number of zeros
        for iz = ((iy-1)*5+1):((iy-1)*5+1+4)
            if (IrisMaskData(ix,iz) == 1)
                one_cnt = one_cnt + 1;
            else
                zero_cnt = zero_cnt + 1;
            end
        end
        if (one_cnt >= 3)
            IrisMajorityData(ix,iy) = 2; % The number for majority one
        else
            IrisMajorityData(ix,iy) = 1; % The number for majority zero
        end
    end
end

% Calculation of the Transitions
IrisTransitionData = zeros(size(IrisMaskData,1),size(IrisMaskData,2)/5);
for ix = 1:size(IrisMaskData,1)
    for iy = 1:size(IrisMaskData,2)/5
        trans_cnt = 0; % Number of Transitions
        for iz = ((iy-1)*5+1):((iy-1)*5+1+3)
            if (IrisMaskData(ix,iz) ~= IrisMaskData(ix,iz+1))
                trans_cnt = trans_cnt + 1;
            end
        end
        if (IrisMaskData(ix,((iy-1)*5+1)) ~= IrisMaskData(ix,((iy-1)*5+1+4)))
        	trans_cnt = trans_cnt + 1;
        end
        if (mod(trans_cnt,2) == 0)
            IrisTransitionData(ix,iy) = 2; % The number for even transitions
        else
            IrisTransitionData(ix,iy) = 1; % The number for odd transitions
        end
    end
end

%OLD: IrisResultsData1 = IrisMajorityData .* IrisTransitionData;
%OLD: IrisResultsData2 = IrisMajorityData + IrisTransitionData;
%OLD: IrisResultsData = IrisResultsData1 ./ IrisResultsData2;

IrisResultsData = IrisMajorityData + IrisTransitionData;

IrisResultsData = IrisResultsData / 5;

IrisOutData = zeros(size(IrisResultsData,1),1);
for ix = 1:size(IrisResultsData,1)
    for iy = 1:size(IrisResultsData,2)
        IrisOutData(ix) = IrisOutData(ix) + IrisResultsData(ix,iy)*(11-iy);
    end
    IrisOutData(ix) = IrisOutData(ix) / sum([1:10]);
end

IrisOutData = IrisOutData + IrisInitialValues;

IrisMaskDataBin = zeros(length(IrisOutData),17);
for im = 1:length(IrisOutData)
    temp_str = num2str(IrisOutData(im));
    temp_str = strcat(temp_str(1),temp_str(3:end));
    for id = 1:(5-length(temp_str))
        temp_str = strcat(temp_str,'0');
    end
    DataBinStr = dec2bin(str2double(temp_str));
    DataBin = zeros(size(DataBinStr,1),size(DataBinStr,2));
    for it = 1:length(DataBinStr)
        DataBin(it) = str2num(DataBinStr(it));
    end
    IrisMaskDataBin(im,(17-length(DataBin)+1):end) = DataBin;
end

IrisFinalData = zeros(length(IrisMaskDataBin),1);
for iw = 1:size(IrisMaskDataBin,1)
    for in = 1:8
        IrisFinalData(iw) = IrisFinalData(iw) + IrisMaskDataBin(iw,in)*2^((9-in)-1);
    end
    IrisFinalData(iw) = roundn(IrisFinalData(iw),1);
end

IrisFinalPlot = zeros(length(IrisFinalData)/5,5);
for icc = 1:length(IrisFinalData)/5
   IrisFinalPlot(icc,1:5) = IrisFinalData((icc-1)*5+1:(icc-1)*5+1+4);
end

figure();
bar(1:20,IrisFinalPlot(1:20,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Iris Data for Mask Generation','FontSize',14);

figure();
bar(21:40,IrisFinalPlot(21:40,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Iris Data for Mask Generation','FontSize',14);

figure();
bar(41:60,IrisFinalPlot(41:60,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Iris Data for Mask Generation','FontSize',14);

%% Analysis of Thumb Data

ThumbMaskData = ThumbMaskData(:,1:50);

ThumbInitialValues = zeros(length(ThumbMaskData),1);
for iw = 1:size(ThumbMaskData,1)
    for in = 1:50
        ThumbInitialValues(iw) = ThumbInitialValues(iw) + ThumbMaskData(iw,in)*2^((51-in)-1);
    end
    ThumbInitialValues(iw) = roundn(ThumbInitialValues(iw),1);
end

ThumbInitialValues = ThumbInitialValues / 10^15;

% Calculation of the Majority Vote
ThumbMajorityData = zeros(size(ThumbMaskData,1),size(ThumbMaskData,2)/5);
for ix = 1:size(ThumbMaskData,1)
    for iy = 1:size(ThumbMaskData,2)/5
        one_cnt = 0; % Number of ones
        zero_cnt = 0; % Number of zeros
        for iz = ((iy-1)*5+1):((iy-1)*5+1+4)
            if (ThumbMaskData(ix,iz) == 1)
                one_cnt = one_cnt + 1;
            else
                zero_cnt = zero_cnt + 1;
            end
        end
        if (one_cnt >= 3)
            ThumbMajorityData(ix,iy) = 2; % The number for majority one
        else
            ThumbMajorityData(ix,iy) = 1; % The number for majority zero
        end
    end
end

% Calculation of the Transitions
ThumbTransitionData = zeros(size(ThumbMaskData,1),size(ThumbMaskData,2)/5);
for ix = 1:size(ThumbMaskData,1)
    for iy = 1:size(ThumbMaskData,2)/5
        trans_cnt = 0; % Number of Transitions
        for iz = ((iy-1)*5+1):((iy-1)*5+1+3)
            if (ThumbMaskData(ix,iz) ~= ThumbMaskData(ix,iz+1))
                trans_cnt = trans_cnt + 1;
            end
        end
        if (ThumbMaskData(ix,((iy-1)*5+1)) ~= ThumbMaskData(ix,((iy-1)*5+1+4)))
        	trans_cnt = trans_cnt + 1;
        end
        if (mod(trans_cnt,2) == 0)
            ThumbTransitionData(ix,iy) = 2; % The number for even transitions
        else
            ThumbTransitionData(ix,iy) = 1; % The number for odd transitions
        end
    end
end

%OLD: ThumbResultsData1 = ThumbMajorityData .* ThumbTransitionData;
%OLD: ThumbResultsData2 = ThumbMajorityData + ThumbTransitionData;
%OLD: ThumbResultsData = ThumbResultsData1 ./ ThumbResultsData2;

ThumbResultsData = ThumbMajorityData + ThumbTransitionData;

ThumbResultsData = ThumbResultsData / 5;

ThumbOutData = zeros(size(ThumbResultsData,1),1);
for ix = 1:size(ThumbResultsData,1)
    for iy = 1:size(ThumbResultsData,2)
        ThumbOutData(ix) = ThumbOutData(ix) + ThumbResultsData(ix,iy)*(11-iy);
    end
    ThumbOutData(ix) = ThumbOutData(ix) / sum([1:10]);
end

ThumbOutData = ThumbOutData + ThumbInitialValues;

ThumbMaskDataBin = zeros(length(ThumbOutData),17);
for im = 1:length(ThumbOutData)
    temp_str = num2str(ThumbOutData(im));
    temp_str = strcat(temp_str(1),temp_str(3:end));
    for id = 1:(5-length(temp_str))
        temp_str = strcat(temp_str,'0');
    end
    DataBinStr = dec2bin(str2double(temp_str));
    DataBin = zeros(size(DataBinStr,1),size(DataBinStr,2));
    for it = 1:length(DataBinStr)
        DataBin(it) = str2num(DataBinStr(it));
    end
    ThumbMaskDataBin(im,(17-length(DataBin)+1):end) = DataBin;
end

ThumbFinalData = zeros(length(ThumbMaskDataBin),1);
for iw = 1:size(ThumbMaskDataBin,1)
    for in = 1:8
        ThumbFinalData(iw) = ThumbFinalData(iw) + ThumbMaskDataBin(iw,in)*2^((9-in)-1);
    end
    ThumbFinalData(iw) = roundn(ThumbFinalData(iw),1);
end

ThumbFinalPlot = zeros(length(ThumbFinalData)/5,5);
for icc = 1:length(ThumbFinalData)/5
   ThumbFinalPlot(icc,1:5) = ThumbFinalData((icc-1)*5+1:(icc-1)*5+1+4);
end

figure();
bar(1:20,ThumbFinalPlot(1:20,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Thumb Data for Mask Generation','FontSize',14);

figure();
bar(21:40,ThumbFinalPlot(21:40,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Thumb Data for Mask Generation','FontSize',14);

figure();
bar(41:60,ThumbFinalPlot(41:60,:),'group');
xlabel('User Index','FontSize',14);
ylabel('Mask Value','FontSize',14);
title('Analysis of Thumb Data for Mask Generation','FontSize',14);

FinalData = IrisFinalData ./ ThumbFinalData;
