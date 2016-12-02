function run()
    inputfilePath = 'filename_d10.spca';
    layers = 2;
    k = 4;
    
    csvInputFilename = 'input.csv';
    convertFiletoCsv(inputfilePath, csvInputFilename);
    
    convertFiletoCsv(inputfilePath, csvInputFilename);
    inputMatrix = csvread(csvInputFilename);

    inputMatrix = transpose(inputMatrix);
    
    vectorMatrix = inputMatrix(6:end, :);
    dimension = size(vectorMatrix, 1);
    buckets = 2^k;

    w = calculateW(dimension, buckets, vectorMatrix);
    hashFunctionFamily = formulateFamilyOfFunctions(dimension, layers, buckets, w);
    
    save('hashFunctionFamily.mat','hashFunctionFamily', 'w');
    
    hashTable = hashVectors(vectorMatrix, hashFunctionFamily, w, layers, buckets);
    
    printResult(hashTable, inputMatrix);
end