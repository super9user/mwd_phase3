function allVideoDistanceMap = run(videoFilePath, siftFilePath)
    
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
end

