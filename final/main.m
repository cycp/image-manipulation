im = im2double(imread('beach.jpg'));
[h w d] = size(im);
focus_h = 80; % set focus rectangle height
change_h = 10; % set mask adjustment height

figure(1);imshow(im);
[col,row] = ginput(1);
mask = zeros(h, w);


res = zeros(h,w,d);


mask_upper = row + focus_h;
mask_lower = row - focus_h;
imsigma = 1;
masksigma = 6;


mask(mask_lower:mask_upper, :) = 1;
blur_im = imgaussfilt(im, imsigma);
blur_mask = imgaussfilt(mask, masksigma);
for dim=1:3
    res_channel = zeros(h,w);
    im_channel = im(:,:,dim);
    blur_im_channel = blur_im(:,:,dim);
    for i=1:h
        for j=1:w
            res_channel(i,j) = im_channel(i,j) * blur_mask(i,j) + ...
                blur_im_channel(i,j) * (1 - blur_mask(i,j));
        end
    end
    res(:,:,dim) = res_channel;
end
imsigma = imsigma + .1;
mask_upper = mask_upper + change_h;
mask_lower = mask_lower - change_h;
im = res;

hsv = rgb2hsv(im);
hsv(:,:,2) = hsv(:,:,2) * 1.5;
hsv(hsv > 1) = 1;
hsv(hsv < 0) = 0;
sat = hsv2rgb(hsv); 
figure; imshow(sat);
imwrite(sat, 'beach_blur.jpg');





