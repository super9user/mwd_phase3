function w = calculateW(dimension, buckets, vectors)
    maxMinMatrix = computeMaxMinMatrix(dimension, vectors);
    maxAbsValues = max(abs(maxMinMatrix(1,:)),abs(maxMinMatrix(2,:)));
    
    meanRange = mean(diff([-maxAbsValues; maxAbsValues])*2*sqrt(buckets));
    w = meanRange/16;
end
