function [ hashTableMap ] = getSet1( hashTable )

    hashTableMap = containers.Map();
    [rows, cols] = size(hashTable);

    for i=1:rows
        for j=1:cols
            layerNum = j;
            bucketNum = hashTable(i, layerNum);
            key = strcat(num2str(layerNum),',',num2str(bucketNum));
            if(~isKey(hashTableMap, key))
                hashTableMap(key) = 0;
            end
            currCount = hashTableMap(key);
            hashTableMap(key) = currCount + 1;
        end
    end
    
end

