function [ orderedPageRank ] = task3( videoDirectory, dataFileName, m)
    
    text=fileread(dataFileName);
    text = strrep(text,'<','');
    text = strrep(text,'>','');
    text = strrep(text,'{','');
    text = strrep(text,'}','');

    fileID = fopen('temp.txt','w');
    fprintf(fileID,text);
    fclose(fileID);
    M = csvread('temp.txt');
    [numPoints y]=size(M); % numPoints in y-dimensional space

    k=2; % TODO - should be dynamic
    z=1; % Counter
    c=0.9;
    totalNodes = numPoints/k;

    clear videoRefMatrix;

    for i=1:totalNodes % from 1 to total rows
        for j=1:k % from 1 to total cols
            row = M(z+j-1,:);
            videoRefMatrix(i,j)=VideoReference(row(1),row(2),row(3),row(4),row(5));
        end
        z=z+k;
    end

    
    for i=1:totalNodes
        obj=videoRefMatrix(i);
        sum=0;
        for j=1:k
            sum=sum+videoRefMatrix(i,j).simValue;
        end
        sVideo=obj.sourceVideo;
        sFrame=obj.sourceFrame;
        dVideo=obj.destinationVideo;
        dFrame=obj.destinationFrame;
        similarityValue=videoRefMatrix(i).simValue;
        similarityMatrix(i)=VideoNodeAscos(sVideo,sFrame,dVideo,dFrame,similarityValue,sum);
    end
    
    for i=1:100
       disp(i);
        for j=1:totalNodes
            obj=similarityMatrix(j);
            summation=findSummation(obj,videoRefMatrix,similarityMatrix);
            %pagerank=1-d + d*summation;
            temp=
            similarity=c*()
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
        videoObj=VideoReader(strcat(videoDirectory, vidKey));
        img=read(videoObj,frameNum);
        pageRank=strcat(' PageRank - ',num2str(pageRankObject.pageRankValue)); 
        videostr=strcat (' Video Number - ',num2str(videoNum));
        videoName=strcat(' Video Name - ',vidKey);
        frameName=strcat (' Frame Number - ',num2str(frameNum));
        title(strcat(videoName,videostr,frameName,pageRank));
        figure, imshow(img);
        imwrite(img,'pageRankFrames.tif','WriteMode','append');
    end

end
 