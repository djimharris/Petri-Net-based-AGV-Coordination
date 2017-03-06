function paths = paths(graph,p11,p12,p21,p22)

% Components of structure (paths)
% pos to indicate the co-ordinate of the position
% connect to store the positions to move to
% connect_to to store the address of the children
% connect_from to store the transition that fired to result in the
% given node
% status to store the nature of the node
% lastNodeAtLevel stores the number of nodes in each level
% lastLevel stores the maximum number of levels of a branch
% connect_no stores the number of children the corresponding node has

if p11==p21 && p12==p22
    disp('Already at required point');
    paths(1,1).pos=[p11 p12];
    paths(1,1).status = 3;
    return 
end

paths(1,1).pos=[p11 p12];
for i = 1:graph(p11,p12).connect_no
    paths(1,1).connect_to(i)=i;
end
paths(1,1).connect = graph(p11,p12).connect;
paths(1,1).status = 1;
paths(1,1).connect_no = graph(p11,p12).connect_no;

lastNodeAtLevel(1) = 1;											% Well, obviously
lastNodeAtLevel(2) = graph(p11,p12).connect_no;					% To keep track of the last node at the next level; here, it's the number of children from the previous level.
nodeCount = 1;

lastLevel=1;

for i = 1:lastNodeAtLevel(2)
	paths(2,nodeCount).pos = paths(1,1).connect(i,:);
    paths(2,nodeCount).connect_from = 1;
	paths(2,nodeCount).status = pathStatus(paths,lastNodeAtLevel,2,nodeCount,p21,p22);
	nodeCount = nodeCount + 1;
end

nodeCount = 0;
lastLevel = 2;

while pathComplete(paths,lastNodeAtLevel,lastLevel) == 0
    nodeCount = 0;
    for j = 1:lastNodeAtLevel(lastLevel)
        if (pathStatus(paths,lastNodeAtLevel,lastLevel,j,p21,p22) == 1)
            paths(lastLevel,j).connect_no = graph(paths(lastLevel,j).pos(1),paths(lastLevel,j).pos(2)).connect_no;
            for k = 1:paths(lastLevel,j).connect_no
                paths(lastLevel,j).connect_to(k) = nodeCount + k;
            end
            paths(lastLevel,j).connect = graph(paths(lastLevel,j).pos(1),paths(lastLevel,j).pos(2)).connect;
            for k = 1:paths(lastLevel,j).connect_no
                nodeCount = nodeCount + 1;
                paths(lastLevel+1,nodeCount).pos = paths(lastLevel,j).connect(k,:);
                paths(lastLevel+1,nodeCount).connect_from = j;
                paths(lastLevel+1,nodeCount).status = pathStatus(paths,lastNodeAtLevel,lastLevel+1,nodeCount,p21,p22);
            end
        end
    end
    lastLevel = lastLevel + 1;
    lastNodeAtLevel(lastLevel) = nodeCount;
end