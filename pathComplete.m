function s = pathComplete(paths,lastNode,lastLevel)

s=1;
i=lastLevel;
for j=1:lastNode(i)
    if paths(i,j).status==1
        s=0;
        return
    end
end