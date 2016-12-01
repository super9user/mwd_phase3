function [ ] = AscosSim()

    tic;
    dataFileName = 'filename_d_k.gspc';
    k=5;
    m=3;

    M = preProcess(dataFileName);

    [numPoints, y] = size(M);
    z=1;
    c=0.9;
    totalNodes = numPoints/k;
    clear videoRefMatrix;

    globalOutgoingMatrix = containers.Map(); % map where incoming node is the key
    globalAscosRankMap = containers.Map(); % map where every node( 'SourceVideo,SourceFrame,DestVideo, DestFrame' is a key)

    for i=1:totalNodes
        for j=1:k
            x=M(z+j-1,1:5);
            videostr=num2str(x(1));
            framestr=num2str(x(2));
            keystr=strcat(videostr,',',framestr);

            o=VideoReference(x(1),x(2),x(3),x(4),x(5));
            videoRefMatrix(i,j)=o;
            if(~isKey(globalOutgoingMatrix, keystr))
                globalOutgoingMatrix(keystr) = [o];
            else
                array=globalOutgoingMatrix(keystr);
                array=[array o];
                globalOutgoingMatrix(keystr)=array;
            end
        end
        z=z+k;
    end


    counter=1;
    for i=1:totalNodes
        list=videoRefMatrix(i,:);
        %sum=0;
        %for j=1:k
        %   sum=sum+videoRefMatrix(i,j).simValue;   %sum is the sum of all edges from i.
        %end
        y=size(list,2);
        for j=1:y
            obj=list(j);
            sVideoNum=obj.sourceVideo;
            sVideo=num2str(sVideoNum);
            sFrameNum=obj.sourceFrame;
            sFrame=num2str(sFrameNum);
            dVideoNum = obj.destinationVideo;
            dVideo = num2str(dVideoNum);
            dFrameNum = obj.destinationFrame;
            dFrame = num2str(dFrameNum);
            
            ascosRankValue=obj.simValue/100;
            mapKey=strcat(sVideo,',',sFrame,',',dVideo,',',dFrame);
            globalAscosRankMap(mapKey)= AscosVideoNode(sVideoNum,sFrameNum,dVideoNum,dFrameNum,ascosRankValue);
            ascosRankMatrix(counter)=AscosVideoNode(sVideoNum,sFrameNum,dVideoNum,dFrameNum,ascosRankValue);
            counter=counter+1;
        end
    end
    toc;

    ascosRankIndex = containers.Map();
    frameVideoArray = frameVideos();
    counter = size(frameVideoArray, 2);
    maxIters = 1;

    for i=1:maxIters % no of iterations
        count = 1;
        for j=1:counter
            disp(j);
            tic;
            objI = frameVideoArray(j);
            sVideo = num2str(objI.video);
            sFrame = num2str(objI.frame);
            
            for k = 1:counter
                objJ = frameVideoArray(k);
                dVideo = num2str(objJ.video);
                dFrame = num2str(objJ.frame);
                mapK = strcat(sVideo,',',sFrame,',',dVideo,',',dFrame);
                
                ascosRank = c * findSum(sVideo, sFrame, dVideo, dFrame, globalAscosRankMap, globalOutgoingMatrix);
                if i == maxIters && ascosRank > 0
                    rKey = strcat(dVideo,',',dFrame);
                    if(isKey(ascosRankIndex, rKey))
                        temp = ascosRankIndex(rKey);
                        temp = temp + ascosRank;
                        ascosRankIndex(rKey) = temp;
                    else
                        ascosRankIndex(rKey) = ascosRank;
                    end
                end
                globalAscosRankMap(mapK)= AscosVideoNode(sVideo, sFrame, dVideo, dFrame, ascosRank);
            end
            toc;
            
        end
    end

    rKeys = keys(ascosRankIndex);
    rSize = size(rKeys, 2);
    for i = 1:rSize
        vidFrame = rKeys(i);
        vidFrame = strsplit(char(vidFrame), ',');
        rank = ascosRankIndex(char(rKeys(i)));
        arrayAscos(i) = AscosRank(vidFrame(1), vidFrame(2), rank);
    end

    arraySize = size(arrayAscos, 2);
    [~, index] = sort([arrayAscos.ascosRankValue], 'descend');
    for random = 1:arraySize
        disp(arrayAscos(index(random)));
    end

end