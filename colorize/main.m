% CS194-26 (cs219-26): Project 1

% name of the input file
imname = 'naziya.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

% Ignore the outer 10% from each side for each image
border = [size(B,2)*0.1, size(B,1)*0.1, size(B,2)*0.8, size(B,1)*0.8];
cropB = imcrop(B, border);
cropG = imcrop(G, border);
cropR = imcrop(R, border);

% Align using G as reference for better alignment
% To test alignment using B as the reference plate, replace the existing lines 
% with the commented out equivalents
if size(cropB,1) <= 500
    disB = align(cropB,cropG,[0,0],15);
    disR = align(cropR,cropG,[0,0],15);
    %disG = align(cropG,cropB,[0,0],15)
    %disR = align(cropR,cropB,[0,0],15)
else
    disB = pyramid(cropB,cropG,0)*2;
    disR = pyramid(cropR,cropG,0)*2;
    %disG = pyramid(cropG,cropB,0)*2
    %disR = pyramid(cropR,cropB,0)*2
end

aB = circshift(B,disB);
aR = circshift(R,disR);
%aG = circshift(G,disG);
%aR = circshift(R,disR);

% create a color image (3D array)
colorim = cat(3,aR,G,aB);
%colorim = cat(3,aR,aG,B);

% Crop a predefined margin
%colorim = imcrop(colorim,border);

% Auto crop the ugly borders -- bells & whistles
% Feel free to adjust the threshold
cropped = crop(colorim, 0.1);

% Auto contrast -- bells & whistles
gray = cropped;
[y, x] = imhist(gray);
min = x(find(y > 0, 1, 'first'));
max = x(find(y > 0, 1, 'last'));
if min ~= 0 && max ~= 1
    adjusted = imadjust(gray,[min; max],[0, 1]);
    contrasted = imhistmatch(cropped, adjusted);
    % save image
    imwrite(contrasted,['contrast-' imname],'jpg');
else 
    imwrite(cropped,['cropped-' imname],'jpg');
end

