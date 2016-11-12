function [allVideoDistanceMatrix, allVideoDistanceReference] = combineAllDistanceMap(allVideoDistanceMap)
    videoKeys = keys(allVideoDistanceMap);
    videoCount = length(videoKeys);
    
    allVideoDistanceMatrix = [];
    allVideoDistanceReference = [];
    
    for i=1:videoCount
        focusVideoDistanceMap = allVideoDistanceMap(num2str(i));
        focusVideoKeys = keys(focusVideoDistanceMap);
        videoSize = size(focusVideoDistanceMap(focusVideoKeys{1}));
        focusVideoFrameCount = videoSize(1);
        selfDistanceMatrix = repmat(10000, [focusVideoFrameCount, focusVideoFrameCount]);
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
end