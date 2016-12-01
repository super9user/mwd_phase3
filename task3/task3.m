function [ orderedPageRank ] = task3(videoDirectory, dataFileName, m)

tic
    M = preProcess(dataFileName);
    
    M_VideoMapFile=csvread('video_mappings_task3.csv');
    globalVideoIndex=containers.Map();
    for i=1:size(M_VideoMapFile)
        x=M_VideoMapFile(i,:);
        key=num2str(x(1));
        vidnum=num2str(x(2));
        videostr=strcat(vidnum,'.mp4');
        globalVideoIndex(key)=videostr;
    end
    [numPoints, ~]=size(M);
    startingVideo=M(1,1);
    startingFrame=M(1,2);

    k=0;
    for i=1:numPoints
        x1=M(i,1);
        x2=M(i,2);
        if(x1==startingVideo && x2==startingFrame)
            k=k+1;
        else
            break;
        end
    end

    z=1;
    d=0.85;
    totalNodes = numPoints/k;
    clear videoRefMatrix;

    globalIncomingMatrix=containers.Map(); % map where incoming node is the key
    globalPageRankMap= containers.Map(); % map where every node( 'video,frame' is a key)
 
    for i=1:totalNodes
        for j=1:k    
            x=M(z+j-1,1:5);
            videostr=num2str(x(3));
            framestr=num2str(x(4));
            keystr=strcat(videostr,',',framestr);

            o=VideoReference(x(1),x(2),x(3),x(4),x(5));
            videoRefMatrix(i,j)=o;
            if(~isKey(globalIncomingMatrix, keystr))
                globalIncomingMatrix(keystr) = [o];
            else
                array=globalIncomingMatrix(keystr);
                array=[array o];
                globalIncomingMatrix(keystr)=array;
            end
        end
        z=z+k;
    end

    for i=1:totalNodes
        obj=videoRefMatrix(i);
        sum=0;
        for j=1:k
            sum=sum+videoRefMatrix(i,j).simValue;
        end
        videoNum=obj.sourceVideo;
        strVideo=num2str(videoNum);
        frameNum=obj.sourceFrame;
        strNum=num2str(frameNum);
        pagerankvalue=1/numPoints/k;
        mapKey=strcat(strVideo,',',strNum);
        globalPageRankMap(mapKey)= VideoNode(videoNum,frameNum,pagerankvalue,sum);  
        pageRankMatrix(i)=VideoNode(videoNum,frameNum,pagerankvalue,sum);
    end

    for i=1:25 % no of iterations
        i
        for j=1:totalNodes       
            obj=pageRankMatrix(j);
            strVideo=num2str(obj.videoNum);
            strFrame=num2str(obj.frameNum);
            mapK=strcat(strVideo,',',strFrame);
            summation=findSummation(obj,globalPageRankMap,globalIncomingMatrix);
            pagerank= (1-d) + (d*summation);
            globalPageRankMap(mapK)= VideoNode(obj.videoNum,obj.frameNum,pagerank,obj.outweight);
        end
    end
    
    allPageRanks = zeros(1,totalNodes);
    allPageRanksMapping = {};
    prKeys = keys(globalPageRankMap);
    for i=1:length(prKeys)
        tmp = prKeys(i);
        currObj = globalPageRankMap(tmp{1});
        allPageRanks(i) = currObj.pageRankValue;
        allPageRanksMapping{i} = currObj;
    end

    [~,idx]=sort(allPageRanks,'descend');
%     orderedPageRank=pageRankMatrix(idx);

%     load 'globalVideoIndex.mat';
    for j=1:m
        currIdx = idx(j);
        obj = allPageRanksMapping(currIdx);
        pageRankObject = obj{1};

        videoNum=pageRankObject.videoNum;
        frameNum=pageRankObject.frameNum;
        vidKey=globalVideoIndex(num2str(videoNum));
        videoObj=VideoReader(strcat(videoDirectory,vidKey));
        img=read(videoObj,frameNum);
        pageRank=strcat(' PageRank - ',num2str(pageRankObject.pageRankValue)); 
        videostr=strcat (' Video Number - ',num2str(videoNum));
        videoName=strcat(' Video Name - ',vidKey);
        frameName=strcat (' Frame Number - ',num2str(frameNum));
       
        imshow(img)
        title(strcat(videoName,videostr,frameName,pageRank))
        if(j~=m) 
            figure();
        end
        imwrite(img,'pageRankFrames.tif','WriteMode','append');
    end
   toc 
end