function [ videoNum, frameNum, cellNum, xCord, yCord, siftVector ] = cleanAndParseDataReducedSift( line )
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
    
    videoNum = str2double(char(firstPart(1)));
    frameNum = str2double(char(firstPart(2)));
    cellNum = str2double(char(firstPart(3)));
    xCord = str2double(char(firstPart(4)));
    yCord = str2double(char(firstPart(5)));
    

    siftPart = strrep(siftPart, '}', '');
    siftPart = strrep(siftPart, ']', '');
    
    x = strsplit(char(siftPart), ',');
    siftVector = zeros(1, length(x));
    
    for j = 1:length(x)
        siftVector(j) = str2double(x(j));
    end
end