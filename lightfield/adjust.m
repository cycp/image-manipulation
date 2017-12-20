function [ adjusted ] = adjust( aperture )

files = dir('rectified/*.png');

% set focus point (default = center)
centerR = 8;
centerC = 8;

row = 0;
col = 0;

avg = zeros(800,1400,3);
for f = files'
    minRow = centerR - aperture;
    maxRow = centerR + aperture;
    minCol = centerC - aperture;
    maxCol = centerC + aperture;
    if (row >= minRow) && (row <= maxRow) && (col >= minCol) && (col <= maxCol)
        img = im2double(imread(['rectified/' f.name])); 
        avg = avg + img;
    end
                 
    col = col + 1;
    if col == 17
        row = row + 1;
        col = 0;
    end
end
adjusted = avg / (aperture*2 + 1)^2;
end

