%read and convert to grayscale
img=imread('F1.jpg');
img=rgb2gray(img);
scene=imread('Faces.jpg');
scene=rgb2gray(scene);
%scene = imnoise(scene,'salt & pepper',0.02);

%detect surf features
imgpoints=detectSURFFeatures(img);
scenepoints=detectSURFFeatures(scene);

%extract descriptors
[imgFeatures, imgpoints] = extractFeatures(img, imgpoints);
[sceneFeatures, scenepoints] = extractFeatures(scene, scenepoints);

%find matches
pairs=matchFeatures(imgFeatures,sceneFeatures);
matchedimgpoints = imgpoints(pairs(:, 1), :);
matchedscenepoints = scenepoints(pairs(:, 2), :);

%find transformation
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedimgpoints, matchedscenepoints, 'affine');

%create a box around the image
boxPolygon = [1, 1;...                           % top-left
        size(img, 2), 1;...                 % top-right
        size(img, 2), size(img, 1);... % bottom-right
        1, size(img, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
    
 newBoxPolygon = transformPointsForward(tform, boxPolygon);

 %show the result
 figure;
imshow(scene);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');