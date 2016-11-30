function maxMinMatrix = computeMaxMinMatrix(dimension, matrix)
    maxMinMatrix = [zeros(1, dimension); ones(1, dimension)];
    
    for i=1:dimension
        maxMinMatrix(1, i) = min(matrix(:, i));
        maxMinMatrix(2, i) = max(matrix(:, i));
    end
end