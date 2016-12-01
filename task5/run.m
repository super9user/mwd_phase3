function run(inputfilePath, layers, k)
    tic
    csvInputFilename = 'input.csv';
    convertFiletoCsv(inputfilePath, csvInputFilename);
    
    convertFiletoCsv(inputfilePath, csvInputFilename);
    inputMatrix = csvread(csvInputFilename);

%     layers = 10;
%     k = 10;
%     inputMatrix = csvread('input.csv');

    inputMatrix = transpose(inputMatrix);
    
    vectorMatrix = inputMatrix(6:end, :);
    dimension = size(vectorMatrix, 1);
    buckets = 2^k;
    
    w = calculateW(dimension, buckets, vectorMatrix);
    hashFunctionFamily = formulateFamilyOfFunctions(dimension, layers, buckets, w);
    
    hashTable = hashVectors(vectorMatrix, hashFunctionFamily, w, layers, buckets);
    
    printResult(hashTable, inputMatrix);
    toc
end