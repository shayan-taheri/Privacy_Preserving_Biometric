%% The function that calculates the fusion of the features of the fingerprint and the iris
function fused_features = Word_Fusion(word_1,word_2)

addpath('C:\Users\shaya\Desktop\Milad Work\Word Features');

feature_word1 = m1_word_feature(word_1);
feature_word2 = m2_word_feature(word_2);

% Sum of Means
fused_features = feature_word1 * feature_word2;

end