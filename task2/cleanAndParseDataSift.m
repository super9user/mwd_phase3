function [ videoNum, frameNum, cellNum, siftVector ] = cleanAndParseDataSift( line )
%   Clean And Parse Data Sift - Utility Function
%   Cleans input Data and converts to appropriate data structure
 
    parts = strsplit(line, ',[');
    
    firstPart = parts(1);
    siftPart = parts(2);
    
    firstPart = strrep(firstPart, '{', '');
    firstPart = strrep(firstPart, '<', '');
    firstPart = strrep(firstPart, '>', '');
    
    firstPart = strsplit(char(firstPart), ',');
    if length(firstPart) ~= 5
        fprintf('Error in sift file. \nLine: %s \nExiting...', line);
        return;
    end
    
    videoNum = char(firstPart(1));
    frameNum = char(firstPart(2));
    cellNum = char(firstPart(3));
    
%     
%     eachPart = strsplit(line, ',');
%     videoNum = 0;
%     frameNum = 0;
%     cellNum = 0;
%     siftVector = 0;
%     vector = [];
%     
%     if(length(eachPart) < 5)
%         return;
%     end
%     videoNum = eachPart(1);
%     videoNum = char(strrep(videoNum, '{', ''));
%     videoNum = char(strrep(videoNum, '<', ''));
%     
%     frameNum = char(eachPart(2));
%     
%     cellNum = char(eachPart(3));
%     

    siftPart = strrep(siftPart, '}', '');
    siftPart = strrep(siftPart, ']', '');
%     
%     siftVector = strrep(siftVector, '[', '');
%     siftVector = strrep(siftVector, '{', '');
%     siftVector = strrep(siftVector, '}', '');
%     siftVector = strrep(siftVector, ']', '');
%     siftVector = strrep(siftVector, ')', '');
%     siftVector = siftVector(1:end-1);
    
    x = strsplit(char(siftPart), ',');
    siftVector = zeros(1, length(x));
    
    for j = 1:length(x)
        siftVector(j) = str2double(x(j));
    end
    
%     k=1;
%     step=(length(siftVector))/132;
%     
%     for i = 1:step:length(x)
%         temp = 0;
%         for j = i:(i+step-1)
%             temp =  temp + (siftVector(j).^2);
%         end
%         vector(k) = temp.^(0.5);
%         k=k+1;
%     end
     
end