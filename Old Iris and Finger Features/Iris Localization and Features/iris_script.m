% **** Iris Localization and Local Cropping ****
clear all; close all; clc;
img = imread('C:\Users\shaya\Desktop\Milad Work\Iris Localization and Features\Example_1.jpg');
img = imresize((img),[256 256]);
[ci,cp,out] = thresh(img,80,100);
% [xc,yc,r] --> For the region boundary
% -------------------------------------
% The Limbic Boundary of Iris --> ci
r = ci(3); x = ci(1); y = ci(2);

XAxisL = (x-1-r:x-1+r);
YAxisL = (y-1-r:y-1+r);
Cropped_ImageL = img(XAxisL,YAxisL);
limb_features = imstat(Cropped_ImageL);
% -------------------------------------
% The Pupillary Boundary of Iris --> cp
r = cp(3); x = cp(1); y = cp(2);

XAxisP = (x-1-r:x-1+r);
YAxisP = (y-1-r:y-1+r);
Cropped_ImageP = img(XAxisP,YAxisP);
pupil_features = imstat(Cropped_ImageP);


new_img = img
new_img(XAxisP,YAxisP) = 1000
new_img = new_img(XAxisL,YAxisL)
imshow(new_img)

% -------------------------------------
iris_features_out = limb_features .* bifurcation_features;