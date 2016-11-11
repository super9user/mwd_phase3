function run(videoFilePath, siftFilePath)
    
%     videoFilePath = '/Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/DataR';
    
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
    
%     video1 = combineSift(databaseMapSift, v1);
%     video2 = combineSift(databaseMapSift, v2);
% 
%     distanceSiftMap1 = computeDistanceSift(video1, video2, metric1);
%     distanceSiftMap2 = computeDistanceSift(video1, video2, metric2);
%     similaritySift1 = computeSimilaritySift(distanceSiftMap1, type1);
%     similaritySift2 = computeSimilaritySift(distanceSiftMap2, type2);
%     
%     disp(similaritySift1);
%     disp(similaritySift2);
end

