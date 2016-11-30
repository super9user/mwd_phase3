function hashFamily = formulateFamilyOfFunctions(vectors, dimension, layers, buckets)
    hashFamily = [];
    maxMinMatrix = computeMaxMinMatrix(dimension, vectors);
    maxAbsValues = max(abs(maxMinMatrix(1,:)),abs(maxMinMatrix(2,:)));
    
end