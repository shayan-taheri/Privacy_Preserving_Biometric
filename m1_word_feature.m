%% The Model 1 for Feature Extraction from Text

function feature_out = m1_word_feature(word)

first_element = letter_index(word(1)); % The first element of feature
second_element = letter_index(word(end)); % The second element of feature
third_element = letter_index(word(ceil(length(word)/2))); % The third element of feature

feature_out = ceil((first_element^third_element) / (second_element^second_element)) * (first_element + second_element);

end