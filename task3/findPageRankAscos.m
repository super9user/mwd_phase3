function [similarity,out]=findPageRank(video,frame,similarityMatrix)

[x y]=size(similarityMatrix);

for i=1:y
    obj=similarityMatrix(i);
    if(obj.svideoNum==video && obj.sframeNum==frame)
        similarity=obj.similarityValue;
        out=obj.outweight;
        break;
    end
end