function run(videoMap, siftFilePath, k, databaseMapSift)
    tic
%   videoFilePath = '/Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/DataR';
%   /Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/Phase3/test/videos
    global r;
    r = 2;
    
%     videoMap = getVideoMap(videoFilePath);
%   siftFilePath = '/Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/Phase3/filename.sift';
%   /Users/jaiswalhome/satyam/masters/fall2016/CSE515-MWDb/project/sourcecode/Phase3/mwd_phase3/task1/filename_d.spca
    

%     databaseMapSift = getDataStructureForSift(siftFilePath);
    allVideoDistanceMap = findVideoDistances(videoMap, databaseMapSift);
    
    [allVideoDistanceMatrix, allVideoDistanceReference] = combineAllDistanceMap(allVideoDistanceMap);
    
    allVideoSimilarityMatrix = 100 * (1 - normc(allVideoDistanceMatrix));
    
    [sortedSimilarityMaxtrix, indices] = sort(allVideoSimilarityMatrix, 2);
    
    graphSize = size(allVideoDistanceMatrix);
    totalFrames = graphSize(1);
    
%     {va, vb, sim(a, b)}
%     va = ?ia, ja? and vb = ?ib, jb?

    fileID = fopen('filename_d_k.gspc', 'w');
    for i=1:totalFrames
        for j=0:k-1
            columnIndex = totalFrames - j;
            col = indices(i, columnIndex);
            referenceObj = allVideoDistanceReference(i, col);
            sourceVideo = referenceObj.sourceVideo;
            destinationVideo = referenceObj.destinationVideo;
            
            while(sourceVideo == destinationVideo)
                columnIndex = columnIndex - 1;
                col = indices(i, columnIndex);
                referenceObj = allVideoDistanceReference(i, col);
                sourceVideo = referenceObj.sourceVideo;
                destinationVideo = referenceObj.destinationVideo;
            end
            
            fprintf(fileID, '\n{<%d, %d>, <%d, %d>, %f}', referenceObj.sourceVideo, referenceObj.sourceFrame, referenceObj.destinationVideo, referenceObj.destinationFrame, sortedSimilarityMaxtrix(i, end-j));
        end
    end
    
    fclose(fileID);
    toc
end