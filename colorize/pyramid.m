function displacement = pyramid( im, ref, level)
%PYRAMID Recursive function to align larger .tif images efficiently
    
    % Align normally if image is small
    if size(im,1) <= 500
        displacement = align(im, ref, [-7,7], 10);
    else
        % Halve the image sizes and recursively call pyramid
        im = imresize(im,0.5);
        ref = imresize(ref,0.5);
        temp = pyramid(im,ref,level+1); %hold the displacement value so far
        displacement = align(im, ref, [temp(1),temp(2)]*2,10); 
    end
      
end