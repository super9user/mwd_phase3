function [ videoFramePairSimMap, totalLength, uniqueLength ] = getSiftsInInputSets( inputVideoNum, set1, LSHMatrix, PCAMatrix, allSiftVectors)

    layerBucketPairs = keys(set1);
    videoFramePairSimMap = containers.Map();
    
    totalLength = 0;
    uniqueLength = 0;
    
    for i=1:length(layerBucketPairs)
        localvideoFramePairSimMap = containers.Map();
        localvideoFrameSimCountMap = containers.Map();
        
        currPair = layerBucketPairs(i);
        splitPair = strsplit(char(currPair), ',');
        layer = str2double(splitPair(1));
        bucket = str2double(splitPair(2));
        
        allLayers = LSHMatrix(:,1);
        layerIdx = find(allLayers == layer);
        layerMatches = LSHMatrix(layerIdx,:);
        
        allBuckets = layerMatches(:,2);
        bucketIdx = find(allBuckets == bucket);
        bucketMatches = layerMatches(bucketIdx,:);
        
        allVideos = bucketMatches(:,3);
        filterIndices = find(allVideos ~= inputVideoNum);
        filteredBucket = bucketMatches(filterIndices,:);
        videoFrameMat = filteredBucket(:,3:4);
        
        
        allVideosFrames = PCAMatrix(:,1:2);
        allIndexesOfSet1 = find(ismember(allVideosFrames, videoFrameMat, 'rows'));
        
        allSIFTOfSet1 = PCAMatrix(allIndexesOfSet1,6:end);
        [uniqueSIFTOfSet1, allSIFTIndexesOfSet1] = unique(allSIFTOfSet1, 'rows');
        uniqueVideoFrameOfSet1 = allVideosFrames(allSIFTIndexesOfSet1,:);
        
        [rows, cols] = size(uniqueSIFTOfSet1);
        [rows1, cols2] = size(uniqueSIFTOfSet1);
        
        totalLength = totalLength + rows1;
        uniqueLength = uniqueLength + rows;
        
        distanceMat = pdist2(allSiftVectors, uniqueSIFTOfSet1);
        MeanMat = mean(distanceMat);
        
        totalNodes = length(MeanMat);
        
        for j=1:totalNodes
            tempArr = uniqueVideoFrameOfSet1(j,:);
            videoNum = tempArr(1);
            frameNum = tempArr(2);
            key = strcat(num2str(videoNum),',',num2str(frameNum));
            if(~isKey(localvideoFramePairSimMap, key))
                localvideoFramePairSimMap(key) = 0;
                localvideoFrameSimCountMap(key) = 0;
            end
            localvideoFramePairSimMap(key) = localvideoFramePairSimMap(key) + MeanMat(j);
            localvideoFrameSimCountMap(key) = localvideoFrameSimCountMap(key) + 1;
        end
        
        allKeys = keys(localvideoFramePairSimMap);
        for k=1:length(allKeys)
            currKey = char(allKeys(k));
            localSim = localvideoFramePairSimMap(currKey);
            localCount = localvideoFrameSimCountMap(currKey);
            diffBetweenUniqueAndAll = length(allSIFTOfSet1) - length(uniqueSIFTOfSet1) + 1;
            simValue = (localSim/(localCount * diffBetweenUniqueAndAll * set1(char(currPair)) ));
            if(~isKey(videoFramePairSimMap, currKey))
                videoFramePairSimMap(currKey) = 0;
            end
            videoFramePairSimMap(currKey) = videoFramePairSimMap(currKey) + simValue;
        end
    end

end