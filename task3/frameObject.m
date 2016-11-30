classdef frameObject
properties
video
frame

end

methods
    function obj=frameObject(videoNum,frameNum)
        if nargin>0
            obj.video=videoNum;
            obj.frame=frameNum;
        end
    end
    
end

end