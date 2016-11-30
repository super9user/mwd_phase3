function run(inputfilePath, layers, k)
    
    csvInputFilename = 'input.csv';
    convertFiletoCsv(inputfilePath, csvInputFilename);
    inputMatrix = csvread(csvInputFilename);
    inputMatrix = transpose(inputMatrix);
    
    vectorMatrix = inputMatrix(6:end, :);
    dimension = size(vectorMatrix, 1);
    buckets = 2^k;
    
    hashFunctionFamily = formulateFamilyOfFunctions(vectorMatrix, dimension, layers, buckets);
end