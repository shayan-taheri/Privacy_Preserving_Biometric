%% The function for preprocessing a single Iris image
function iris_proc(Original_Path,Normalized_Path, ...
                        Template_Path,Circles_Path,User_Name,Image_Name)

addpath([Original_Path,'\',User_Name]);
eyeimage_filename = [Original_Path,'\',User_Name,'\',Image_Name];

eyeimage = imread(eyeimage_filename); 

% Normalisation Parameters --> Creating a 9600 bit Iris Template
radial_res = 20;
angular_res = 240;

% Feature Encoding Parameters
nscales = 1;
minWaveLength = 18;
mult = 1; % Not Applicable for "nscales = 1"
sigmaOnf = 0.5;
 
[circleiris circlepupil imagewithnoise] = segmentiris(eyeimage);

imagewithcircles = uint8(eyeimage);

% Get pixel coord structure (coordinations) for circle around iris
[x,y] = circlecoords([circleiris(2),circleiris(1)],circleiris(3),size(eyeimage));
ind2 = sub2ind(size(eyeimage),double(y),double(x)); 

% Get pixel coord structure (coordinations) for circle around pupil
[xp,yp] = circlecoords([circlepupil(2),circlepupil(1)],circlepupil(3),size(eyeimage));
ind1 = sub2ind(size(eyeimage),double(yp),double(xp));

% Write Circles Overlayed
imagewithcircles(ind2) = 255;
imagewithcircles(ind1) = 255;

% Perform Normalisation

[polar_array noise_array] = normaliseiris(imagewithnoise, circleiris(2),...
    circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3),eyeimage_filename, radial_res, angular_res);

cd(Normalized_Path);
mkdir(User_Name);
imwrite(polar_array,[Normalized_Path,'\',User_Name,'\',Image_Name]);

% Perform Feature Encoding
[template mask] = encode(polar_array, noise_array, nscales, minWaveLength, mult, sigmaOnf);

cd(Template_Path);
mkdir(User_Name);
imwrite(template,[Template_Path,'\',User_Name,'\',Image_Name]);

cd(Circles_Path);
imwrite(imagewithcircles,[Circles_Path,'\',Image_Name]);

end
