function [ frameSiftMap ] = getUniqueSIFTForFrames( frameSiftMap, key, videoNum, frameNum, PCAMatrix )

    currVectors = frameSiftMap(key);
    
    allVideos = PCAMatrix(:,1);
    videoIdx = find(allVideos == videoNum);
    videoMatches = PCAMatrix(videoIdx,:);

    allFrames = videoMatches(:,2);
    frameIdx = find(allFrames == frameNum);
    frameMatches = videoMatches(frameIdx,:);
    
    [rows, ~] = size(frameMatches);
    
    uniqueSIFT = unique(frameMatches, 'rows');
    
    
    parfor k=1:rows
        fullRow = frameMatches(k,:);
        currSift = fullRow(6:end);
        if(~ismember(currSift,currVectors))
            vertcat(currVectors, currSift);
        end
    end
    
    frameSiftMap(key) = currVectors;

end

