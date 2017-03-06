function [pathArray_2 pathSize_2 pathTime_2 pathIndex] = consolidatePaths(agv)
pathArray_2 = [];
pathTime_2 = [];
pathSize_2 = [];
pathIndex = [];
count=1;
for i = 1:3
    for j = 1:size(agv(i).pathArray,1)
        for k = 1:size(agv(i).pathArray,2)
            pathArray_2(count,k,1) = agv(i).pathArray(j,k,1);
            pathArray_2(count,k,2) = agv(i).pathArray(j,k,2);
        end
        pathSize_2(count) = agv(i).pathSize(j);
        pathTime_2(count) = agv(i).pathTime(j);
        pathIndex(count) = i;
        count=count+1;
    end
end

for i = 1:size(pathTime_2,2)
		small = i;
		for j = (i + 1):size(pathTime_2,2)
			if pathTime_2(j) < pathTime_2(small)
				small = j;
			end
		end
		temp1 = pathTime_2(i);
		pathTime_2(i) = pathTime_2(small);
		pathTime_2(small) = temp1;

		temp2 = pathSize_2(i);
		pathSize_2(i) = pathSize_2(small);
		pathSize_2(small) = temp2;

		temp3 = pathArray_2(i,:,:);
		pathArray_2(i,:,:) = pathArray_2(small,:,:);
		pathArray_2(small,:,:) = temp3;
        
        temp4 = pathIndex(i);
		pathIndex(i) = pathIndex(small);
		pathIndex(small) = temp4;
	end