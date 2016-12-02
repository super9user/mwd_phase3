function [ allSIFTVectors ] = getSIFTVectorsinRectangle( PCAMatrix, inputObject, minX, maxX, minY, maxY )

    allSIFTVectors = [];
    totalLength = length(PCAMatrix(1,:));
    
    videoNums = PCAMatrix(:,1);
    videoIdx = find(videoNums == inputObject.videoNum);
    videoMatches = PCAMatrix(videoIdx, :);
    
    frameNums = videoMatches(:,2);
    frameIdx = find(frameNums == inputObject.frameNum);
    frameMatches = videoMatches(frameIdx, :);
    
    [m, ~] = size(frameMatches);
    
    for i=1:m
        curr = frameMatches(i,:);
        xVal = curr(4);
        yVal = curr(5);
        if( (xVal >= minX && xVal <= maxX) && (yVal >= minY && yVal <= maxY) )
            allSIFTVectors = [ allSIFTVectors; frameMatches(i,6:totalLength) ];
        end
    end
    
end

