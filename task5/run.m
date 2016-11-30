function run(inputfilePath, layers, k)
    csvInputFilename = 'input.csv';
    convertFiletoCsv(inputfilePath, csvInputFilename);
    inputMatrix = csvread(csvInputFilename);
    dimension = size(inputMatrix, 2) - 5;
end