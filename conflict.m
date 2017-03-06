function status = conflict(pathArray,pathSize,agv,curr_agv)

%Returns 1 in case of conflict
%Returns 0 otherwise

status = 0;
for i = 1:pathSize
    for j = 1:3
        if agv(j).status == 1
            for k = 1:agv(j).rem
                if pathArray(1,i,1)==agv(j).path(1,k,1) && pathArray(1,i,2)==agv(j).path(1,k,2)
                    status = 1;
                    return
                end
            end
        end
        
         if agv(j).status == 0
             if curr_agv~=j
                if pathArray(1,i,1)==agv(j).curr(1) && pathArray(1,i,2)==agv(j).curr(2)
                    status = 1;
                    return
                end
             end
         end
    end
end

