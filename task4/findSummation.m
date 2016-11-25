function summation=  findSummation(obj, GM, GIM) % current object, GM=globalPageRankMap, GIM= globalIncomingMatrix

    summation=0;
    targetV=obj.videoNum;
    targetF=obj.frameNum;
    videostr=num2str(targetV);
    framestr=num2str(targetF);
    mapKey=strcat(videostr,',',framestr);
    
    if(isKey(GIM, mapKey))
        objectArray=GIM(mapKey);
        [~, v]= size(objectArray);
        for i=1:v
            adjNode=objectArray(i);
            wx=adjNode.simValue;
            [pageRank, outweigh]=findPageRank(adjNode.sourceVideo,adjNode.sourceFrame,GM);
            summation=summation+(wx*pageRank/outweigh);
        end
    end
    
end