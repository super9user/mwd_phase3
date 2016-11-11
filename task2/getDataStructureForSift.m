function [ globalMap ] = getDataStructureForSift(fileName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
    text = fileread(fileName);
    strs = strsplit(text, '\n');

    globalMap = containers.Map();
    for i=1:length(strs)
        newTxt = strtrim(strs{i});
        [ videoNum, frameNum, cellNum, vector ] = cleanAndParseDataSift(strsplit(newTxt, ';'));

        if(videoNum == 0)
            continue;
        end
        
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

    end
 
end

