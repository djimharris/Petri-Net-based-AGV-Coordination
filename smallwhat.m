function smallWhat = smallWhat(paths)

for i = 1:size(paths,1)
    for j = 1:size(paths,2)
        if paths(i,j).status == 3
            smallWhat = [i j];
            return
        end
    end
end
    