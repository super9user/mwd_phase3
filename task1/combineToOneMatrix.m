function [combinedMatrix] = combineToOneMatrix(globalMap)

    combinedMatrix = [];
    vid_keys = keys(globalMap);
    for i = 1:length(vid_keys)
        vid_element = globalMap(char(vid_keys(i)));
        frame_keys = keys(vid_element);
        for j = 1:length(frame_keys)
            frame_element = vid_element(char(frame_keys(j)));
            cell_keys = keys(frame_element);
            for k = 1:length(cell_keys)
                combinedMatrix = vertcat(combinedMatrix, frame_element(char(cell_keys(k))));
            end
        end
    end 
end
