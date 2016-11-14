function [dataMatrix] = combineData(inputMap)
    dataMatrix = [];
    cellKeys = keys(inputMap);
    for i = 1:length(cellKeys)
        eachFrame = inputMap(char(cellKeys(i)));
        cellkeys = i * ones(size(eachFrame, 1), 1);
        eachFrame = horzcat(cellkeys, eachFrame);
        dataMatrix = vertcat(dataMatrix, eachFrame);
    end
end
