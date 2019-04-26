%% The function that calculates the features of Iris
function iris_feature_out = iris_feature(iris_img_name)

iris_img = imread(iris_img_name);
iris_img = imresize((iris_img),[256 256]);
[ci,cp,out] = thresh(iris_img,80,100);
% [xc,yc,r] --> For the region boundary
% -------------------------------------
% The Limbic Boundary of Iris --> ci
r = ci(3); x = ci(1); y = ci(2);

XAxisL = (x-1-r:x-1+r);
YAxisL = (y-1-r:y-1+r);
Cropped_ImageL = iris_img(XAxisL,YAxisL);
iris_feature_out = mean(mean(Cropped_ImageL));
iris_feature_out = round(iris_feature_out);
iris_feature_out = double(iris_feature_out);

end