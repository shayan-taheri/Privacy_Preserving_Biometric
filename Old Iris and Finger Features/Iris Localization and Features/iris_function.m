%% The function that calculates the features of Iris
function iris_features_out = iris_function(iris_img_name)

iris_img = imread(iris_img_name);
iris_img = imresize((iris_img),[256 256]);
[ci,cp,out] = thresh(iris_img,100,200);
% [xc,yc,r] --> For the region boundary
% -------------------------------------
% The Limbic Boundary of Iris --> ci
r = ci(3); x = ci(1); y = ci(2);

XAxisL = (x-1-r:x-1+r);
YAxisL = (y-1-r:y-1+r);
Cropped_ImageL = iris_img(XAxisL,YAxisL);
limb_features = imstat(Cropped_ImageL);
% -------------------------------------
% The Pupillary Boundary of Iris --> cp
r = cp(3); x = cp(1); y = cp(2);

XAxisP = (x-1-r:x-1+r);
YAxisP = (y-1-r:y-1+r);
Cropped_ImageP = iris_img(XAxisP,YAxisP);
pupil_features = imstat(Cropped_ImageP);
% -------------------------------------
iris_features_out = limb_features .* pupil_features;

end