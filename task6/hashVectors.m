function hTable = hashVectors(vectors, hashFunctionFamily, w, layers, buckets)
    hTable = [];
    for i=1:layers
        a0 = double(vectors);
        a0 = a0';
        b1 = hashFunctionFamily(i).A;
        size(a0)
        size(b1)
        a1 = mmtimes(a0, b1);
        clear a0;
        clear b1;
        a2 = repmat(hashFunctionFamily(i).b,size(vectors,2),1);
        a3 = (a1 - a2) / w;
        clear a1;
        clear a2;
        v = floor(a3);
        clear a3;
%         v = floor((double(vectors)'*hashFunctionFamily(i).A - repmat(hashFunctionFamily(i).b,size(vectors,2),1))/w);
        v = uint8(v+128);
        v = sum(v, 2);
        v = mod(v, buckets);
        v = v + 1;
        hTable = horzcat(hTable, v);
    end
end