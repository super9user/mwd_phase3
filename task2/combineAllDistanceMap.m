function [allVideoDistanceMatrix, allVideoDistanceReference] = combineAllDistanceMap(allVideoDistanceMap)
    videoKeys = keys(allVideoDistanceMap);
    videoCount = length(videoKeys);
    
    allVideoDistanceMatrix = [];
    
    
    for i=1:videoCount
        focusVideoDistanceMap = allVideoDistanceMap(num2str(i));
        focusVideoKeys = keys(focusVideoDistanceMap);
        videoSize = size(focusVideoDistanceMap(focusVideoKeys{1}));
        focusVideoFrameCount = videoSize(1);
        selfDistanceMatrix = repmat(100000, [focusVideoFrameCount, focusVideoFrameCount]);
%         sourceVideo = i;
        rowMatrix = [];
        
        for j=1:videoCount
%             destinationVideo = j;
            if i == j
                rowMatrix = horzcat(rowMatrix, selfDistanceMatrix);
            else
                distanceMatrix = focusVideoDistanceMap(num2str(j));
                rowMatrix = horzcat(rowMatrix, distanceMatrix);
            end
        end
        
        allVideoDistanceMatrix = vertcat(allVideoDistanceMatrix, rowMatrix);
    end
    
    allVideoDistanceMatrixDimension = size(allVideoDistanceMatrix);
    tempReference = VideoReference(1, 1, 1, 1);
    allVideoDistanceReference = repmat(tempReference, [allVideoDistanceMatrixDimension(1), allVideoDistanceMatrixDimension(2)]);
    
    x = 0;
    y = 0;
    
    for i=1:videoCount
        focusVideoDistanceMap = allVideoDistanceMap(num2str(i));
        focusVideoKeys = keys(focusVideoDistanceMap);
        videoSize = size(focusVideoDistanceMap(focusVideoKeys{1}));
        focusVideoFrameCount = videoSize(1);
%         selfDistanceMatrix = repmat(10000, [focusVideoFrameCount, focusVideoFrameCount]);
        
        for j=1:videoCount
            if i == j
%                 rowMatrix = horzcat(rowMatrix, selfDistanceMatrix);
                for m = 1:focusVideoFrameCount
                    for n=1:focusVideoFrameCount
                        allVideoDistanceReference(x+m, y+n) = VideoReference(i, m, j, n);
                    end
                end
                y = y + focusVideoFrameCount;
            else
                distanceMatrix = focusVideoDistanceMap(num2str(j));
                currentVideoSize = size(distanceMatrix);
                currentVideoFrameCount = currentVideoSize(2);
%                 rowMatrix = horzcat(rowMatrix, distanceMatrix);
                for m = 1:focusVideoFrameCount
                    for n=1:currentVideoFrameCount
                        allVideoDistanceReference(x+m, y+n) = VideoReference(i, m, j, n);
                    end
                end
                
                y = y + currentVideoFrameCount;
            end
            
            
        end
        
%         allVideoDistanceMatrix = vertcat(allVideoDistanceMatrix, rowMatrix);
        x = x + focusVideoFrameCount;
        y=0;
    end
end