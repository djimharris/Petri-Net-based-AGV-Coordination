function status = pathStatus(paths,lastNode,k1,k2,p21,p22)

% Status Legend:
% 1   -   Incomplete branch
% 2   -   Dead end branch
% 3   -   End branch

status = 1;

if paths(k1,k2).pos == [p21 p22]
    status = 3;
    return
end

t1 = k1-1;
t2 = paths(k1,k2).connect_from;

flag=0;

for i = 1:k1-1
    if sum(paths(k1,k2).pos == paths(t1,t2).pos) == 2
        flag = 1;
        status = 2;
        return
    end 
    if t1 > 1
        t2 = paths(t1,t2).connect_from;
        t1 = t1-1;
    end
end

return



