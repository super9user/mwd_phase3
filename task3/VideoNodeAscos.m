classdef VideoNodeAscos
    
   properties
       svideoNum;
       sframeNum;
       dvideoNum;
       dframeNum;
       similarityValue;
       outweight;
   end
   
   methods
      function obj = VideoNode(sVideo,sFrame,dVideo,dFrame,similarityValue,ow)
         if nargin > 0
            obj.videoNum = sVideo;
            obj.frameNum = sFrame;
            obj.dvideoNum=dVideo;
            obj.dframeNum=dFrame;
            obj.similarityValue=similarityValue;
            obj.outweight=ow;
         end
      end
   end
   
end