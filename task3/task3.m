function [ orderedPageRank ] = task3( videoDirectory, dataFileName, m)
text=fileread(dataFilename);
text = strrep(text,'<','');
text = strrep(text,'>','');
text = strrep(text,'{','');
text = strrep(text,'}','');

fileID = fopen('temp.txt','w');
fprintf(fileID,text);
fclose(fileID);
M = csvread('temp.txt');

[numPoints y]=size(M);
k=5;
numPoint
z=1;
m=4;
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

for i=1:100 % no of iterations
    i
   for j=1:totalNodes       
    obj=pageRankMatrix(j);
    strVideo=num2str(obj.videoNum);
    strFrame=num2str(obj.frameNum);
    mapK=strcat(strVideo,',',strFrame);
    summation=findSummation(obj,globalPageRankMap,globalIncomingMatrix);
    pagerank=1-d+d*summation;
    globalPageRankMap(mapK)= VideoNode(obj.videoNum,obj.frameNum,pagerank,obj.outweight);  
   end
end
% [~,idx]=sort([pageRankMatrix.pageRankValue],'descend');
% orderedPageRank=pageRankMatrix(idx);
% 
% for j=1:m
%     pageRankObject=orderedPageRank(j);
%     videoNum=pageRankObject.videoNum;
%     frameNum=pageRankObject.frameNum;
%     vidKey=globalVideoIndex(num2str(videoNum));
%     videoObj=VideoReader(strcat('P2DemoVideos/',vidKey));
%    img=read(videoObj,frameNum);
%    pageRank=strcat(' PageRank - ',num2str(pageRankObject.pageRankValue)); 
%    videostr=strcat (' Video Number - ',num2str(videoNum));
%    videoName=strcat(' Video Name - ',vidKey);
%    frameName=strcat (' Frame Number - ',num2str(frameNum));
%    title(strcat(videoName,videostr,frameName,pageRank));
%    figure, imshow(img);
%    imwrite(img,'pageRankFrames.tif','WriteMode','append');
% end
end