function summation=  findSummation(obj,a,similarityMatrix)

[x y]= size(a);
summation=0;
targetV=obj.videoNum;
targetF=obj.frameNum;
    for i=1:x
        for j=1:y        
        adjNode=a(i,j);
        if(adjNode.destinationVideo==targetV && adjNode.destinationFrame==targetF)
            wx=adjNode.simValue;
            [pageRank, outweigh]=findPageRank(adjNode.sourceVideo,adjNode.sourceFrame,similarityMatrix);
            summation=summation+(wx*pageRank/outweigh);
        end

    end
end