function [ videoNum, frameNum, cellNum, siftVector ] = cleanAndParseDataSift( eachPart )
%   Clean And Parse Data Sift - Utility Function
%   Cleans input Data and converts to appropriate data structure

    videoNum = 0;
    frameNum = 0;
    cellNum = 0;
    siftVector = 0;
    vector = [];
    
    if(length(eachPart) < 5)
        return;
    end
    videoNum = eachPart(1);
    videoNum = char(strrep(videoNum, '(', ''));
    frameNum = char(eachPart(2));
    cellNum = char(eachPart(3));
    siftVector = char(eachPart(4));
    siftVector = strrep(siftVector, '[', '');
    siftVector = strrep(siftVector, '{', '');
    siftVector = strrep(siftVector, '}', '');
    siftVector = strrep(siftVector, ']', '');
    siftVector = strrep(siftVector, ')', '');
    siftVector = siftVector(1:end-1);
    
    x = strsplit(siftVector);
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