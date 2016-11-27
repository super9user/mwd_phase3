classdef AscosVideoNode
    
   properties
       sVideoNum;
       sFrameNum;
       dVideoNum;
       dFrameNum;
       similarityValue;
       
   end
   
   methods
      function obj = AscosVideoNode(sVideo, sFrame, dVideo, dFrame, similarity)
         if nargin > 0
            obj.sVideoNum = sVideo;
            obj.sFrameNum = sFrame;
            obj.dVideoNum = dVideo;
            obj.dFrameNum = dFrame;
            obj.similarityValue=similarity;
            
         end
      end
   end
end