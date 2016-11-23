function distance = findFrame2FrameDistance(video1frame, video2frame)
    global r;
    distance = 0;
    cellCount = r*r;
    
    for i=1:cellCount
        cellDistance = 10000;
        if isKey(video1frame, num2str(i))
            if isKey(video2frame, num2str(i))
                frame1cell = video1frame(num2str(i));
                frame2cell = video2frame(num2str(i));
%                 cellDistance = findCell2CellDistance(frame1cell, frame2cell);
                cellDistanceMatrix = pdist2(frame1cell, frame2cell);
                dim = size(cellDistanceMatrix);
                totalVectors = dim(1)*dim(2);
                cellDistance = sum(cellDistanceMatrix);
                cellDistance = sum(cellDistance)/totalVectors;
            end
        end
        distance = distance + cellDistance;
    end
    
    distance = distance/cellCount;
end