function pathTime = sortTest(pathTime)
for i = 1:size(pathTime,2)
		small = i;
		for j = (i + 1):size(pathTime,2)
			if pathTime(j) < pathTime(small)
				small = j;
			end
		end
		temp = pathTime(i);
		pathTime(i) = pathTime(small);
		pathTime(small) = temp;
end
end