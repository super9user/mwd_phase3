function [] = pcaReductionSift(filename, k)
    tic
    filename1 = fopen('filename_d.spca', 'w');
    filename2 = fopen('indexScore', 'w'); 
    completeMatrix = csvread(filename);
    mForReduction = completeMatrix(:, 6:135);
    [coeff, scores, latent] = pca(mForReduction);
    reducedMatrix = mForReduction * coeff(:, 1:k);
    reducedMatrix = reducedMatrix(:, 1:k);
    for i = 1:size(reducedMatrix, 1)
        fprintf(filename1, '{<%d,%d,%d,%.6f,%.6f>,[', completeMatrix(i, 1), completeMatrix(i, 2), completeMatrix(i, 3), completeMatrix(i, 4), completeMatrix(i, 5));
        fprintf(filename1, '%.6f, ', reducedMatrix(i, 1:k-1));
        fprintf(filename1, '%.6f', reducedMatrix(i, k));
        fprintf(filename1, ']}\n');  
    end
    toc
%     completeMatrix = combineToOneMatrix(globalMap);
%     eigenValues = eig(cov(completeMatrix));
%     eigenValues = normc(eigenValues);
%     [ev order] = sort(eigenValues, 'descend');
%     for i = 1:k
%         fprintf(filename2, '<');
%         fprintf(filename2, '%d ', order(i));
%         fprintf(filename2, ',');
%         fprintf(filename2, '%.6f', ev(i)); 
%         fprintf(filename2, '> ');                 
%         fprintf(filename2, '\n');
%     end
%     toc
end