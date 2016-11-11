classdef Video
   properties
      name;
      videoReaderObject;
   end
   methods
      function obj = Video(filename, videoReaderObj)
         if nargin > 0
            obj.name = filename;
            obj.videoReaderObject = videoReaderObj;
         end
      end
   end
end