% Calculating the Statistical Measures of a Data Vector (Function)
function stat_vec = vecstat(data_vec)

% Read the data vector
% stat_vec = The vector of statistical measures 

% Vector of Data Stats
stat_vec = zeros(1,12);
max_val = max(data_vec);
max_cnt = 0;
for i = 1:length(data_vec)
    if data_vec(i) == max_val
        max_cnt = max_cnt + 1;
    end
end
stat_vec(1) = max_cnt; % (1) Number of Maximum Value
stat_vec(2) = mean(data_vec); % (2) Average Value
stat_vec(3) = median(data_vec); % (3) Median Value
min_val = min(data_vec);
min_cnt = 0;
for i = 1:length(data_vec)
	if data_vec(i) == min_val
        min_cnt = min_cnt + 1;
	end
end
stat_vec(4) = min_cnt; % (4) Number of Minimum Value
stat_vec(5) = mode(data_vec); % (5) Mode Value
stat_vec(6) = std(data_vec); % (6) Standard Deviation
THH = mean(data_vec) + 3 * std(data_vec);
CntH = 0;
for i = 1:length(data_vec)
	if data_vec(i) > THH
        CntH = CntH + 1;
	end
end
stat_vec(7) = CntH; % (7) High Threshold Count

THL = mean(data_vec);
CntL = 0;
for i = 1:length(data_vec)
	if data_vec(i) < THL
        CntL = CntL + 1; % (8) Low Threshold Count
	end
end
stat_vec(8) = CntL;

stat_vec(9) = kurtosis(data_vec); % (9) Kurtosis Value 
stat_vec(10) = skewness(data_vec); % (10) Skewness Value
stat_vec(11) = norm(data_vec,1); % (11) Manhattan Norm
stat_vec(12) = norm(data_vec,2); % (12) Euclidean Norm

end