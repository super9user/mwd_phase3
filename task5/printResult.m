function printResult(hashTable, inputMatrix)
    
    fileID = fopen('filename_d.lsh', 'w');
    layer = size(hashTable, 2);
    vcount = size(hashTable, 1);
    
%     layer num, bucket num, ?i; j; l; x; y? 
    for i=1:vcount
        video = inputMatrix(1, i);
        frame = inputMatrix(2, i);
        cell = inputMatrix(3, i);
        x = inputMatrix(4, i);
        y = inputMatrix(5, i);
        for j=1:layer
            lay_num = j;
            bucket_num = hashTable(i, lay_num);
            fprintf(fileID, '{%d, %d, <%d; %d; %d; %.6f; %.6f>}\n', lay_num, bucket_num, video, frame, cell, x, y);
        end
    end
    
    fclose(fileID);
end