function movements = movements(pathArray,pathSize,previousPos)
	% LEGEND--------------------------------------------------
	% Front - 2
	% Left - 4
	% Right - 6
	% Backwards - 8
	for i = 1:size(pathArray,1)
		count = 1;
		prev = previousPos;
		for j = 1:pathSize(i)-1
			
			curr = [pathArray(i,j,1) pathArray(i,j,2)];
			next = [pathArray(i,j+1,1) pathArray(i,j+1,2)];
			ang = turnAngle(prev,curr,next);
			
			if ang == 90
				movements(i,count) = 4; %Left
				count = count + 1;
			end
			if ang == -90
				movements(i,count) = 6; %Right
				count = count + 1;
			end
			if (ang == 180) || (ang == -180)
				movements(i,count) = 8; %Backwards
				count = count + 1;
			end
			
			movements(i,count) = 2;
			count = count + 1;
			prev = curr;
		end
	end
end