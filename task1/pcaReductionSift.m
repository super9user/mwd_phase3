function [] = pcaReductionSift(globalMap, k)
    tic
    filename1 = fopen('filename_d.spca', 'w');
    filename2 = fopen('indexScore', 'w'); 
    vidKeys = keys(globalMap);
    for i = 1:length(vidKeys)
        eachVideo = globalMap(char(vidKeys(i)));
        frameKeys = keys(eachVideo);
        for j = 1:length(frameKeys)
            i, j
            frameElement = eachVideo(char(frameKeys(j)));
            eachFrame = combineData(frameElement)
            [coeff, scores, latent] = pca(eachFrame(:, 4:133));
            size(eachFrame), size(coeff)
            resultMatrix = eachFrame(:, 4:133)*coeff(:, 1:k);
            resultMatrix = resultMatrix(:, 1:k);
             for x = 1:size(resultMatrix, 1)
                 fprintf(filename1, '{<%d,%d,%d,%.6f,%.6f>,[', str2double(vidKeys(i)), str2double(frameKeys(j)), eachFrame(x, 1), eachFrame(x, 2), eachFrame(x, 3));
                 fprintf(filename1, '%.6f, ', resultMatrix(x, 1:k-1));
                 fprintf(filename1, '%.6f', resultMatrix(x, k));
                 fprintf(filename1, ']}\n');
             end
        end
    end
    completeMatrix = combineToOneMatrix(globalMap);
    eigenValues = eig(cov(completeMatrix));
    eigenValues = normc(eigenValues);
    [ev order] = sort(eigenValues, 'descend');
    for i = 1:k
        fprintf(filename2, '<');
        fprintf(filename2, '%d ', order(i));
        fprintf(filename2, ',');
        fprintf(filename2, '%.6f', ev(i)); 
        fprintf(filename2, '> ');                 
        fprintf(filename2, '\n');
    end
    toc
end