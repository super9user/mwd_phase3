function [dataMatrix] = combineData(inputMap)
    dataMatrix = [];
    cellKeys = keys(inputMap);
    for i = 1:length(cellKeys)
        eachFrame = inputMap(char(cellKeys(i)));
        dataMatrix = vertcat(dataMatrix, eachFrame);
    end
end
