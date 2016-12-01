function hashFamily = formulateFamilyOfFunctions(dimension, layers, buckets, w)
    for i=1:layers
        hashFamily(i).A = randn(dimension, buckets);
        hashFamily(i).b = unifrnd(0, w, 1, buckets);
    end
end