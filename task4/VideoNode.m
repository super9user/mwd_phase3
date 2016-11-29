classdef VideoNode
    
   properties
       videoNum;
       frameNum;
   end
   
   methods
      function obj = VideoNode(sVideo, sFrame)
         if nargin > 0
            obj.videoNum = sVideo;
            obj.frameNum = sFrame;
         end
      end
   end
   
end