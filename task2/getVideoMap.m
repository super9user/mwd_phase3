function videoMap = getVideoMap(videoFilePath)
    fileNames = dir(strcat(videoFilePath, '/*.mp4'));
    
    filesCount = length(fileNames);
    videoMap = containers.Map();
    for file=1:filesCount
        vr = VideoReader(strcat(videoFilePath,'/',fileNames(file).name));
        v = Video(fileNames(file).name, vr);
        videoMap(num2str(file)) = v;
    end
end