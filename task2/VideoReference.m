classdef VideoReference
   
   properties
      sourceVideo;
      sourceFrame;
      destinationVideo;
      destinationFrame;
   end
   
   methods
      function obj = VideoReference(sVideo, sFrame, dVideo, dFrame)
         if nargin > 0
            obj.sourceVideo = sVideo;
            obj.sourceFrame = sFrame;
            obj.destinationVideo = dVideo;
            obj.destinationFrame = dFrame;
         end
      end
   end
   
end