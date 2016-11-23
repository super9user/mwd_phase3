function printVideoMap(videoMap)
    videoKeys = keys(videoMap);
    videoCount = length(videoKeys);
    
    fileID = fopen('video_mappings.csv', 'w');
    
    for i=1:videoCount
        currentVideo = videoMap(char(videoKeys(i)));
        fprintf(fileID, '\n%s: %s', char(videoKeys(i)), currentVideo.name);
    end
    
    fclose(fileID);
end