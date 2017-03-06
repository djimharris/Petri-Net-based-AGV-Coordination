function [pathArray,pathSize] = allWhat(paths)

pathCount = 0;

for i = 1:size(paths,1)
    for j = 1:size(paths,2)
        if paths(i,j).status == 3
            pathCount = pathCount + 1;
            pathIndex = i;
            pathSize(pathCount) = i;
            posX = i;
            posY = j;
            while pathIndex>0
                pathArray(pathCount,pathIndex,1) = paths(posX,posY).pos(1);
                pathArray(pathCount,pathIndex,2) = paths(posX,posY).pos(2);
                pathIndex = pathIndex - 1;
                posY = paths(posX,posY).connect_from;
                posX = posX - 1;
            end  
        end
    end
end