%function [] = ascosMeasures()
tic
InputMatrix = preProcess('filename_d_k.gspc');

    [numPoints, ~]=size(InputMatrix);
    startingVideo=InputMatrix(1,1);
    startingFrame=InputMatrix(1,2);
    k=0;
    for i=1:numPoints
        x1=InputMatrix(i,1);
        x2=InputMatrix(i,2);
        if(x1==startingVideo && x2==startingFrame)
            k=k+1;
        else
            break;
        end
    end
    

    z=1;
    totalNodes = numPoints/k;
    
    indexMapping = containers.Map();
    for i=1:totalNodes
        currentRow = InputMatrix(z,:);
        vidNum = currentRow(1);
        frameNum = currentRow(2);
        keystr = strcat(num2str(vidNum),',',num2str(frameNum));
        indexMapping(keystr) = i;
        z=z+k;
    end
    
    % Fill transition matrix X
    X = zeros(totalNodes,totalNodes);
    z=1;
    for i=1:totalNodes
        for j=1:k
            currentRow = InputMatrix(z,:);
            sourceVidNum = currentRow(1);
            sourceFrameNum = currentRow(2);
            destVidNum = currentRow(3);
            destFrameNum = currentRow(4);
            simValue = currentRow(5);
            
            sourceKeystr = strcat(num2str(sourceVidNum),',',num2str(sourceFrameNum));
            destKeystr = strcat(num2str(destVidNum),',',num2str(destFrameNum));
            
            sourceIndex = indexMapping(sourceKeystr);
            destIndex = indexMapping(destKeystr);
            
            X(sourceIndex, destIndex) = simValue;
            X(destIndex, sourceIndex) = simValue;
            z=z+1;
        end
    end
    GuessMatrix = X;
    adjMatrix = X;
    clear X;
    idx = find(GuessMatrix ~= 0);
    GuessMatrix(idx) = 1;
    P = normcSum(adjMatrix);
    Ones = ones(size(adjMatrix));
    Q = P.*(Ones - exp(-(adjMatrix)));
    IdentityMat = eye(size(adjMatrix, 1));
    c = 0.9;
    AMatrix = (IdentityMat - (c .* Q'));
    for i = 1:size(adjMatrix, 1)
        i
        BMatrix = (1 - c)*IdentityMat(:,i);
        Sim(:, i) = jacobi(AMatrix, BMatrix, GuessMatrix(:, i), c, 25);
    end
   %calculate sum of all columns in an array, add it to an object containing dVideo and dFrame.
   %Sort the objects and retrieve top n
   sumColumns = sum(Sim);
   keysIndex = keys(indexMapping);
   for i = 1:size(keysIndex, 2)
        index = indexMapping(char(keysIndex(i)));
        vidFrame = keysIndex(i);
        vidFrame = strsplit(char(vidFrame), ',');
        videoNum = vidFrame(1);
        frameNum = vidFrame(2);
        ascosM = sumColumns(index);
        arrayAscos(i) = AscosRank(videoNum, frameNum, ascosM);
   end
   arraySize = size(arrayAscos, 2);
   [~, index] = sort([arrayAscos.ascosRankValue], 'descend');
   for random = 1:arraySize
        disp(arrayAscos(index(random)));
   end
  toc
%end