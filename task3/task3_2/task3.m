filename='test.csv';
text=fileread(filename);
text = strrep(text,'<','');
text = strrep(text,'>','');
text = strrep(text,'{','');
text = strrep(text,'}','');

fileID = fopen('temp.txt','w');
fprintf(fileID,text);
fclose(fileID);
M = csvread('temp.txt');
[numPoints y]=size(M);
k=3;
z=1;
m=4;
d=0.85;
for i=1:numPoints/k
    
    for j=1:k    
        x=M(z+j-1,1:5);
        a(i,j)=VideoReference(x(1),x(2),x(3),x(4),x(5));
    end
    z=z+3;
end
for i=1:numPoints/k
    obj=a(i);
    sum=0;
    for j=1:k
        sum=sum+a(i,j).simValue;
    end
    videoNum=obj.sourceVideo;
    frameNum=obj.sourceFrame;
    pagerankvalue=1/numPoints/k;
    pageRankMatrix(i)=VideoNode(videoNum,frameNum,pagerankvalue,sum);
end
for i=1:100
    i
   for j=1:numPoints/k
    obj=pageRankMatrix(j);
    summation=findSummation(obj,a,pageRankMatrix);
    pagerank=1-d+d*summation;
    pageRankMatrix(j).pageRankValue=pagerank;
   end
end
[~,idx]=sort([pageRankMatrix.pageRankValue],'descend');
orderedPageRank=pageRankMatrix(idx);

for j=1:m
    pageRankObject=orderedPageRank(j);
    videoNum=pageRankObject.videoNum;
    frameNum=pageRankObject.frameNum;
    vidKey=globalVideoIndex(num2str(videoNum));
    videoObj=VideoReader(strcat('P2DemoVideos/',vidKey));
   img=read(videoObj,frameNum);
   pageRank=strcat(' PageRank - ',num2str(pageRankObject.pageRankValue)); 
   videostr=strcat (' Video Number - ',num2str(videoNum));
   videoName=strcat(' Video Name - ',vidKey);
   frameName=strcat (' Frame Number - ',num2str(frameNum));
   title(strcat(videoName,videostr,frameName,pageRank));
   figure, imshow(img);
   imwrite(img,'pageRankFrames.tif','WriteMode','append');
end
 