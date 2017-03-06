function [pathArray,pathTime,pathSize] = pathArrange(pathArray,pathSize,previousPosition,transTime,rotTime)
	if nargin == 3
		transTime = 10;
		rotTime = 5;
	end
	% pathTime is an array which stores the time taken for each path coming through "paths"
	% prev, curr, and next store positions
    % previousPosition is entered as a row vector - [1 1]
	
	for i = 1:size(pathArray,1)
		time = 0;
		prev = previousPosition;
		for j = 1:pathSize(i)-1
			curr = [pathArray(i,j,1) pathArray(i,j,2)];
			next = [pathArray(i,j+1,1) pathArray(i,j+1,2)];
			ang = turnAngle(prev,curr,next);
			if (ang == -90) || (ang == 90)
				time = time + rotTime;
			end
			if ang == 180
				time = time + 2*rotTime;
			end
			time = time + transTime;
			prev = curr;
		end
		pathTime(i) = time;
	end
% Sorting begins based on pathTime
	for i = 1:size(pathTime,2)
		small = i;
		for j = (i + 1):size(pathTime,2)
			if pathTime(j) < pathTime(small)
				small = j;
			end
		end
		temp1 = pathTime(i);
		pathTime(i) = pathTime(small);
		pathTime(small) = temp1;

		temp2 = pathSize(i);
		pathSize(i) = pathSize(small);
		pathSize(small) = temp2;

		temp3 = pathArray(i,:,:);
		pathArray(i,:,:) = pathArray(small,:,:);
		pathArray(small,:,:) = temp3;
	end
end