function [ originalDataArr ] = getDataStructureForReducedSift(reducedSiftFilePath)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
    text = fileread(reducedSiftFilePath);
    strs = strsplit(text, '\n');

%     globalMap = containers.Map();
    originalDataArr = [];
    for i=1:length(strs)
        
        newTxt = strtrim(strs{i});
        
        if(~isempty(newTxt))
            [ videoNum, frameNum, cellNum, xPos, yPos, vector ] = cleanAndParseDataReducedSift(newTxt);

            if(videoNum == 0)
                continue;
            end
        
            obj = SiftPosition(videoNum, frameNum, cellNum, xPos, yPos, vector);
            originalDataArr = cat(1, originalDataArr, [obj]);
        
            %{
            if(~isKey(globalMap, videoNum))
                globalMap(videoNum) = containers.Map();
            end
            videoMap = globalMap(videoNum);

            if(~isKey(videoMap, frameNum))
                videoMap(frameNum) = containers.Map();
            end
            frameMap = videoMap(frameNum);

            if(~isKey(frameMap, cellNum))
                frameMap(cellNum) = [];
            end
            array_vectors = frameMap(cellNum);
            array_vectors = vertcat(array_vectors, vector);
            frameMap(cellNum) = array_vectors;
            %}
        end
    end
end

