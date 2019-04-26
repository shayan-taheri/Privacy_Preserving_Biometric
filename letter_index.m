%% The function that outputs the index of a letter in the English alphabets
function index_out = letter_index(letter)

English_Alphabets_UC = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N', ...
    'O','P','Q','R','S','T','U','V','W','X','Y','Z'];

English_Alphabets_LC = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n', ...
    'o','p','q','r','s','t','u','v','w','x','y','z'];

for i = 1:length(English_Alphabets_UC)
   if ((letter == English_Alphabets_UC(i)) || (letter == English_Alphabets_LC(i)))
       index_out = i;
   end
end

end