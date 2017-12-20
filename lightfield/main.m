
%% DEPTH REFOCUSING PART 

% set the scale for shifting
for scale = 0:3
    refocused = refocus(scale);
    imshow(refocused);
%     imwrite(refocused, ['refocused_' scale], 'jpg');
end


%% APERTURE PART

for aperture = 0:8
    adjusted = adjust(aperture);
    imshow(adjusted);
%     imwrite(avg, ['adjusted_' aperture], 'jpg');
end

    