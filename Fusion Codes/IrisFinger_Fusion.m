%% The function that calculates the fusion of the features of the fingerprint and the iris
function fused_features = IrisFinger_Fusion(iris_img_name,finger_img_name)

addpath('C:\Users\shaya\Desktop\Milad Work\Fingerprint Minutiae Extraction');
addpath('C:\Users\shaya\Desktop\Milad Work\Iris Localization and Features');

iris_features_out = iris_feature(iris_img_name);
inp = int32(iris_features_out);
inp_str = num2str(inp);
if (str2num(inp_str(end)) < 5)
    iris_features_out = iris_features_out - str2num(inp_str(end));
else
    iris_features_out = iris_features_out + (10 - str2num(inp_str(end)));
end

finger_features_out = finger_feature(finger_img_name);
inp = int32(finger_features_out);
inp_str = num2str(inp);
if (str2num(inp_str(end)) < 5)
    finger_features_out = finger_features_out - str2num(inp_str(end));
else
    finger_features_out = finger_features_out + (10 - str2num(inp_str(end)));
end

fused_features = iris_features_out + finger_features_out;

end