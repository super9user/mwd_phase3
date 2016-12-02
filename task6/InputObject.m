classdef InputObject
    
   properties
       videoNum;
       frameNum;
       x1;
       y1;
       x2;
       y2;
   end
   
   methods
      function obj = InputObject(sVideo, sFrame, xValue1, yValue1, xValue2, yValue2)
         if nargin > 0
            obj.videoNum = str2double(sVideo);
            obj.frameNum = str2double(sFrame);
            obj.x1 = str2double(xValue1);
            obj.y1 = str2double(yValue1);
            obj.x2 = str2double(xValue2);
            obj.y2 = str2double(yValue2);
         end
      end
   end
   
end