function videoDistanceArr = findVideoToVideoDistance(video1Sift, video1FrameCount, video2Sift, video2FrameCount, videoDistanceArr)
    for i=1:video1FrameCount
        if isKey(video1Sift, num2str(i))
            video1frame = video1Sift(num2str(i));
            
            for j=1:video2FrameCount
                if isKey(video2Sift, num2str(j))
                    video2frame = video2Sift(num2str(j));
                    videoDistanceArr(i, j) = findFrame2FrameDistance(video1frame, video2frame);
                end
            end
        end
    end
end