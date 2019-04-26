%% The function that generates the output key
function key_out = Key_Gen(iris_img_name,finger_img_name,word_1,word_2)

fused_all = All_Fusion(iris_img_name,finger_img_name,word_1,word_2);

key_out = fused_all*fused_all;

end