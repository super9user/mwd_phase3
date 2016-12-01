function [ rprScore ] = task4( videoDirectory, dataFileName, m, seed1Str, seed2Str, seed3Str )

    InputMatrix = preProcess(dataFileName);
    M_VideoMapFile=csvread('video_mappings_task3.csv');
    globalVideoIndex=containers.Map();
    for i=1:size(M_VideoMapFile)
        x=M_VideoMapFile(i,:);
        key=num2str(x(1));
        vidnum=num2str(x(2));
        videostr=strcat(vidnum,'.mp4');
        globalVideoIndex(key)=videostr;
    end

    [numPoints, ~]=size(InputMatrix);
    startingVideo=InputMatrix(1,1);
    startingFrame=InputMatrix(1,2);
    k=0;
    for i=1:numPoints
        x1=InputMatrix(i,1);
        x2=InputMatrix(i,2);
        if(x1==startingVideo && x2==startingFrame)
            k=k+1;
        else
            break;
        end
    end
    
    clear nodeVideoMapping;
%     nodeVideoMapping ith Index -> ith VideoNode Object
%     indexMapping ('VidNum,FrameNum') key -> Index for this combination
% X is transition matrix

    z=1;
    totalNodes = numPoints/k;
    
    indexMapping = containers.Map();
    for i=1:totalNodes
        currentRow = InputMatrix(z,:);
        vidNum = currentRow(1);
        frameNum = currentRow(2);
        nodeVideoMapping(i) = VideoNode(vidNum, frameNum);
        keystr = strcat(num2str(vidNum),',',num2str(frameNum));
        indexMapping(keystr) = i;
        z=z+k;
    end
    
    % Fill transition matrix X
    X = zeros(totalNodes,totalNodes);
    z=1;
    for i=1:totalNodes
        for j=1:k
            currentRow = InputMatrix(z,:);
            sourceVidNum = currentRow(1);
            sourceFrameNum = currentRow(2);
            destVidNum = currentRow(3);
            destFrameNum = currentRow(4);
            simValue = currentRow(5);
            
            sourceKeystr = strcat(num2str(sourceVidNum),',',num2str(sourceFrameNum));
            destKeystr = strcat(num2str(destVidNum),',',num2str(destFrameNum));
            
            sourceIndex = indexMapping(sourceKeystr);
            destIndex = indexMapping(destKeystr);
            
            X(sourceIndex, destIndex) = simValue;
            z=z+1;
        end
    end
    
    seed1 = indexMapping(seed1Str);
    seed2 = indexMapping(seed2Str);
    seed3 = indexMapping(seed3Str);
    seedSet = [seed1 seed2 seed3];
    
    % Run RPR-2 algo
    rprScore = robustPersonalizedPageRank(X, seedSet);

    [prValues, idx]=sort(rprScore, 'descend');
    
    for j=1:m
        currIdx = idx(j);
        pageRankObject = nodeVideoMapping(currIdx);

        videoNum=pageRankObject.videoNum;
        frameNum=pageRankObject.frameNum;
        vidKey=globalVideoIndex(num2str(videoNum));
        
        videoObj=VideoReader(strcat(videoDirectory,vidKey));
        img=read(videoObj,frameNum);
        pageRank=strcat(' PersonalizedPageRank - ',num2str(prValues(currIdx))); 
        videostr=strcat (' Video Number - ',num2str(videoNum));
        videoName=strcat(' Video Name - ',vidKey);
        frameName=strcat (' Frame Number - ',num2str(frameNum));
        imshow(img)
        title(strcat(videoName,videostr,frameName,pageRank))
        if(j~=m) 
            figure();
 
        imwrite(img,'pageRankFramesPPR.tif','WriteMode','append');
    end
    
end

