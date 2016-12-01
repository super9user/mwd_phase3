function hTable = hashVectors(vectors, hashFunctionFamily, w, layers, buckets)
    hTable = [];
    for i=1:layers
        v = floor((double(vectors)'*hashFunctionFamily(i).A - repmat(hashFunctionFamily(i).b,size(vectors,2),1))/w);
        v = uint8(v+128);
        v = sum(v, 2);
        v = mod(v, buckets);
        v = v + 1;
        hTable = horzcat(hTable, v);
    end
end