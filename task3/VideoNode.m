classdef VideoNode
    
   properties
       videoNum;
       frameNum;
       pageRankValue;
       outweight;
   end
   
   methods
      function obj = VideoNode(sVideo, sFrame,pageRank,ow)
         if nargin > 0
            obj.videoNum = sVideo;
            obj.frameNum = sFrame;
            obj.pageRankValue=pageRank;
            obj.outweight=ow;
         end
      end
   end
   
end