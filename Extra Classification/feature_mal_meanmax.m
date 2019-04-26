function out_feature = feature_mal_meanmax(in_feature)

% Infecting the training features
for it = 1:length(in_feature)/512
    genvarname(['Chunk_',num2str(it)]);
    eval(['Chunk_',num2str(it),' = in_feature((it-1)*512+1:(it-1)*512+1+511);']);
end
% The class for manipulation of data
data.mean = zeros(1,8);
data.index = zeros(1,8);
for iy = 1:length(in_feature)/512
    data.mean(iy) = eval('mean([''Chunk_'',num2str(iy)])');
    data.index(iy) = iy;
end

mali_index = zeros(1,8);
ip = 1;
while (length(data.mean) ~= 0)
    diff_vec = abs(data.mean(ip)-data.mean);
    [max_val,max_ind] = max(diff_vec);
    mali_index(data.index(ip)) = data.index(max_ind);
    mali_index(data.index(max_ind)) = data.index(ip);
    data.mean(max_ind) = [];
    data.index(max_ind) = [];
    data.mean(ip) = [];
    data.index(ip) = [];
end

eval(['out_feature = [Chunk_',num2str(mali_index(1)), ...
    ';Chunk_',num2str(mali_index(2)), ...
    ';Chunk_',num2str(mali_index(3)), ...
    ';Chunk_',num2str(mali_index(4)), ...
    ';Chunk_',num2str(mali_index(5)), ...
    ';Chunk_',num2str(mali_index(6)), ...
    ';Chunk_',num2str(mali_index(7)), ...
    ';Chunk_',num2str(mali_index(8)),'];']);

end