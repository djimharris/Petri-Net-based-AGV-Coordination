function movement = movement(pathArray,pathSize,previousPos)
	% LEGEND--------------------------------------------------
	% Front - 2
	% Left - 4
	% Right - 6
	% Backwards - 8
	for i = 1:size(pathArray,1)
		
		prev = previousPos;
		for j = 1:pathSize(i)-1
		
			curr = pathArray(i,j,:);
			next = pathArray(i,j+1,:);
			ang = turnAngle(prev,curr,next);
			
			if ang == 0
				movement(i,j) = 2; %Front
			end
			if ang == 90
				movement(i,j) = 4; %Left
			end
			if ang == -90
				movement(i,j) = 6; %Right
			end
			if ang == 180
				movement(i,j) = 8; %Backwards
			end

			prev = curr;
		end
	end
end