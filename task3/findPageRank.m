function [pageRank,out]=findPageRank(video,frame,GM)

    videostr=num2str(video);
    framestr=num2str(frame);
    mapKey=strcat(videostr,',',framestr);
    obj=GM(mapKey);
    pageRank=obj.pageRankValue;
    out=obj.outweight;

end