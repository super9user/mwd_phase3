classdef SiftPosition
   
   properties
      video;
      frame;
      cell;
      x;
      y;
      vector;
      layer = 0;
      bucket = 0;
   end
   
   methods
      function obj = SiftPosition(v, f, c, x, y, vector)
         if nargin > 0
            obj.video = v;
            obj.frame = f;
            obj.cell = c;
            obj.x = x;
            obj.y = y;
            obj.vector = vector;
         end
      end
   end
end