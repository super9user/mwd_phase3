function allDistanceMap = findVideoDistances(videoMap, databaseMapSift)
    allDistanceMap = containers.Map();
    videoKeys = keys(videoMap);
    n = length(videoKeys);
    
    for i=1:n
        if(~isKey(allDistanceMap, videoKeys{i}))
            allDistanceMap(videoKeys{i}) = containers.Map();
        end
        videoDistanceMap = allDistanceMap(videoKeys{i});
        
        video1 = videoMap(videoKeys{i}).videoReaderObject;
        video1FrameCount = video1.numberOfFrames;
        
        for j=1:n
            video2 = videoMap(videoKeys{j}).videoReaderObject;
            video2FrameCount = video2.numberOfFrames;
            
            if i~=j
                
                if(~isKey(videoDistanceMap, videoKeys{j}))
                    videoDistanceMap(videoKeys{j}) = repmat(10000, [video1FrameCount, video2FrameCount]);
                end
                
                videoDistanceArr = videoDistanceMap(videoKeys{j});
                
                
                if isKey(databaseMapSift, videoKeys{i})
                    video1Sift = databaseMapSift(videoKeys{i});
                    
                    if isKey(databaseMapSift, videoKeys{j})
                        video2Sift = databaseMapSift(videoKeys{j});
                        videoDistanceArr = findVideoToVideoDistance(video1Sift, video1FrameCount, video2Sift, video2FrameCount, videoDistanceArr);
                        videoDistanceMap(videoKeys{j}) = videoDistanceArr;
                    end
                end
            end
        end
    end
end