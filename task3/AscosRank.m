classdef AscosRank
    
   properties
       dVideoNum;
       dFrameNum;
       ascosRankValue;
       
   end
   
   methods
      function obj = AscosRank(dVideo, dFrame, ascosRankValue)
         if nargin > 0
            obj.dVideoNum = dVideo;
            obj.dFrameNum = dFrame;
            obj.ascosRankValue=ascosRankValue;
         end
      end
   end
end