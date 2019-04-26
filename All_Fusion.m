%% The function that calculates the fusion of all the features
function fused_all = All_Fusion(iris_img_name,finger_img_name,word_1,word_2)

fused_IF = IrisFinger_Fusion(iris_img_name,finger_img_name);

fused_W = Word_Fusion(word_1,word_2);

if (fused_IF >= fused_W)
    fused_all = round(fused_IF/fused_W);
else
    fused_all = round(fused_W/fused_IF);
end

end