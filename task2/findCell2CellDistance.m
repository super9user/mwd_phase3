function cellDistance = findCell2CellDistance(frame1cell, frame2cell)
    cellDistance = 10000;
    cell1size = size(frame1cell);
    cell1vectorCount = cell1size(1);
    cell2size = size(frame2cell);
    cell2vectorCount = cell2size(1);
    
    for i=1:cell1vectorCount
        vector1 = frame1cell(i,:);
        for j=1:cell2vectorCount            
            vector2 = frame2cell(j,:);
            dist = pdist2(vector1, vector2);
            
            if dist<cellDistance
                cellDistance = dist;
            end
        end
    end
end