function displacement = align(im, ref, window, range)
%ALIGN Find the best alignment that minimizes the SSD

    min = inf;
    
    % Given a displacement window, check for a good alignment over the
    % given range
    for x = window(1)-range:window(1)+range
    	for y = window(2)-range:window(2)+range
    		shifted = circshift(im, [x,y]);
    		norm = sum(sum((shifted - ref).^2));
    		if norm < min
    			min = norm;
                displacement = [x,y];
    		end
    	end
    end
end
