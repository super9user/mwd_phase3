function run(videoFilePath, siftFilePath, k)
    
%     videoFilePath = '/Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/DataR';
    global r;
    r = 2;
    
    fileNames = dir(strcat(videoFilePath, '/*.mp4'));
    
    filesCount = length(fileNames);
    videoMap = containers.Map();
    for file=1:filesCount
        vr = VideoReader(strcat(videoFilePath,'/',fileNames(file).name));
        v = Video(fileNames(file).name, vr);
        videoMap(num2str(file)) = v;
    end
    
%     siftFilePath = '/Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/Phase3/filename.sift';
    databaseMapSift = getDataStructureForSift(siftFilePath);
    allVideoDistanceMap = findVideoDistances(videoMap, databaseMapSift);
    
    [allVideoDistanceMatrix, allVideoDistanceReference] = combineAllDistanceMap(allVideoDistanceMap);
    
    allVideoSimilarityMatrix = 100 * (1 - normc(allVideoDistanceMatrix));
    
    [sortedSimilarityMaxtrix, indices] = sort(allVideoSimilarityMatrix, 2);
    
    graphSize = size(allVideoDistanceMatrix);
    totalFrames = graphSize(1);
    
%     {va, vb, sim(a, b)}
%     va = ?ia, ja? and vb = ?ib, jb?
    
    for i=1:totalFrames
        for j=0:k-1
            col = indices(i, end-j);
            referenceObj = allVideoDistanceReference(i, col);
            fprintf('\n {<%d, %d>, <%d, %d>, %f}', referenceObj.sourceVideo, referenceObj.sourceFrame, referenceObj.destinationVideo, referenceObj.destinationFrame, sortedSimilarityMaxtrix(i, end-j));
        end
    end
end

