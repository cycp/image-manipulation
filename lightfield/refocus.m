function [ shifted ] = refocus( scale )

files = dir('rectified/*.png');

% set focus point (default = center)
centerR = 8;
centerC = 8;

row = 0;
col = 0;
shifted = zeros(800,1400,3);
for f = files'
    img = im2double(imread(['rectified/' f.name]));    
    dx = col - centerC;
    dy = -1 * (row - centerR);
    
    shifted_img = circshift(img, dy * scale, 1);
    shifted_img = circshift(shifted_img, dx * scale, 2);
    shifted = shifted + shifted_img;
    
    col = col + 1;
    if col == 17
        row = row + 1;
        col = 0;
    end
end

shifted = shifted / 289;
end

