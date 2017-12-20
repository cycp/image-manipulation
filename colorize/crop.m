function cropIm = crop(im, thresh)
%CROP Automatic cropping of the input im, based on given threshold

% Find the edges of the image
borderX = size(im,2);
borderY = size(im,1);

% Use Sobel edge detection on each of the color channels
R = edge(im(:,:,1),'Sobel');
G = edge(im(:,:,2),'Sobel');
B = edge(im(:,:,3),'Sobel');

% Take the average over the rows/columns for each color channel
meanRRows = mean(R,1);
meanRCols = mean(R,2);
meanGRows = mean(G,1);
meanGCols = mean(G,2);
meanBRows = mean(B,1);
meanBCols = mean(B,2);

% Initialize boundaries to default values
left = 0;
top = 0;
right = borderX;
bot = borderY;

% Find the cropping limit for the left 10% of the image
for i = 1:borderX*0.1
    if meanRRows(i) > thresh || meanGRows(i) > thresh || meanBRows(i) > thresh 
        left = i;
    end
end

% Find the cropping limit for the top 10% of the image
for i = 1:borderY*0.1
    if meanRCols(i) > thresh || meanGCols(i) > thresh || meanBCols(i) > thresh
        top = i;
    end
end

% Find the cropping limit for the right 10% of the image
for i = borderX:-1:borderX*0.9
    if meanRRows(i) > thresh || meanGRows(i) > thresh || meanBRows(i) > thresh 
        right = i;
    end
end

% Find the cropping limit for the bottom 10% of the image
for i = borderY:-1:borderY*0.9
    if meanRCols(i) > thresh || meanGCols(i) > thresh || meanBCols(i) > thresh
        bot = i;
    end
end

% Crop the image according to the calculations done above
cropIm = im(top:bot,left:right,:);


