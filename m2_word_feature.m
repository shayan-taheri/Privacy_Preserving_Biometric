%% The Model 2 for Feature Extraction from Text

function feature_out = m2_word_feature(word)

first_element = length(word); % The first element of feature = Word Length

letter_array(1) = word(1);
i = 1;
j = 1;
while(i <= length(word))
    cond_repeat = 0;
    for k = 1:length(letter_array)
        if (word(i) == letter_array(k))
            cond_repeat = 1;
        end
    end
    if (cond_repeat == 1)
        i = i + 1;
    else
        j = j + 1;
        letter_array(j) = word(i);
        i = i + 1;
    end
end

freq_array = zeros(1,length(letter_array));

for r = 1:length(letter_array)
    for y = 1:length(word)
        if (letter_array(r) == word(y))
            freq_array(r) = freq_array(r) + 1;
        end
    end 
end

% The second element of feature = The number of occurrence of the most repeated character
second_element = max(freq_array);

rank_array = zeros(1,length(letter_array));
for w = 1:length(rank_array)
    rank_array(w) = letter_index(letter_array(w));
end

% The third element of feature =
% The difference between the highest and the lowest indices
% among the characters in the word
third_element = max(rank_array) - min(rank_array);

feature_out = round((first_element + second_element + third_element)/3) ^ ceil(first_element/third_element);

end