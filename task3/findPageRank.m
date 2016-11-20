function [pageRank,out]=findPageRank(video,frame,pageRankMat)

[x y]=size(pageRankMat);

for i=1:y
    obj=pageRankMat(i);
    if(obj.videoNum==video && obj.frameNum==frame)
        pageRank=obj.pageRankValue;
        out=obj.outweight;
        break;
    end
end