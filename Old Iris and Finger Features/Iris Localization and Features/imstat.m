% Calculating the Statistical Measures of an Image (Function)
function stat_vec = imstat(img)

% Read the image from the file
% filename = The name of an image with any format
% stat_vec = The vector of statistical measurs 

img = imresize((img),[256 256]);

% Vector of Image Stats
stat_vec = zeros(1,12);
max_val = max(max(img));
max_cnt = 0;
for i = 1:256
    for j = 1:256
        if img(i,j) == max_val
            max_cnt = max_cnt + 1;
        end
    end
end
stat_vec(1) = max_cnt; % (1) Number of Maximum Value
stat_vec(2) = mean(mean(img)); % (2) Average Value
stat_vec(3) = median(median(img)); % (3) Median Value
min_val = min(min(img));
min_cnt = 0;
for i = 1:256
    for j = 1:256
        if img(i,j) == min_val
            min_cnt = min_cnt + 1;
        end
    end
end
stat_vec(4) = min_cnt; % (4) Number of Minimum Value
stat_vec(5) = mode(mode(img)); % (5) Mode Value
stat_vec(6) = std2(img); % (6) Standard Deviation
THH = 3 * std2(img) + mean2(img);
CntH = 0;
for i = 1:256
    for j = 1:256
        if img(i,j) > THH
            CntH = CntH + 1;
        end
    end
end
stat_vec(7) = CntH; % (7) High Threshold Count

THL = mean2(img);
CntL = 0;
for i = 1:256
    for j = 1:256
        if img(i,j) < THL
            CntL = CntL + 1; % (8) Low Threshold Count
        end
    end
end
stat_vec(8) = CntL;

img_dec = im2double(img);
stat_vec(9) = kurtosis(kurtosis(img_dec)); % (9) Kurtosis Value 
stat_vec(10) = skewness(skewness(img_dec)); % (10) Skewness Value
stat_vec(11) = norm(img_dec,1); % (11) Manhattan Norm
stat_vec(12) = norm(img_dec,2); % (12) Euclidean Norm

end