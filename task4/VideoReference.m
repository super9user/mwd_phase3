classdef VideoReference
   
   properties
      sourceVideo;
      sourceFrame;
      destinationVideo;
      destinationFrame;
      simValue;
   end
   
   methods
      function obj = VideoReference(sVideo, sFrame, dVideo, dFrame,valSim)
         if nargin > 0
            obj.sourceVideo = sVideo;
            obj.sourceFrame = sFrame;
            obj.destinationVideo = dVideo;
            obj.destinationFrame = dFrame;
            obj.simValue=valSim;
         end
      end
   end
   
end