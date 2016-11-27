function [ rprScore ] = robustPersonalizedPageRank( seed1, seed2 )
%robustPersonalizedPageRank RPR-2
%   Detailed explanation goes here

    seedSet = [seed1 seed2];
    seedSetSize = length(seedSet);

%     X = [[0 1 0 0 0]; [1 0 0 0 0 ]; [0 1 0 0 0]; [0 0 1 0 1]; [0 0 0 1 0]];
    X = [[0 1 1 1 0 0 0 0 0]; ...
        [0 0 0 0 1 0 0 0 0]; ...
        [0 0 0 0 1 0 0 0 0 ]; ...
        [0 0 0 0 1 1 1 0 0]; ...
        [0 0 0 0 1 0 0 0 0]; ...
        [0 0 0 1 0 0 0 0 0]; ...
        [0 0 0 1 0 0 0 1 1]; ...
        [0 0 0 0 0 0 1 0 0]; ...
        [0 0 0 0 0 0 1 0 0]];
    [n, ~] = size(X);
    
    beta = 0.15;
    maxIter = 100;
    
    % Restart vectors
    ESet = zeros(seedSetSize, n);
    
    for i=1:seedSetSize
        seed = seedSet(i);
        currE = ESet(i,:);
        currSeed = seedSet(i);
        for j=1:n
            if(j == currSeed)
                currE(1, j) = 1; % Should this be really 1?
            end
        end
        ESet(i,:) = currE;
    end
    
    pagerankSet = zeros(seedSetSize, n);
    for i=1:seedSetSize
        pagerankSet(i,:) = ones(1,n) * 1/n;
    end

    for i=1:maxIter
        for j=1:seedSetSize
            currPRSet = pagerankSet(j,:);
            currE = ESet(j,:);
            currPRSet = (1 - beta)*currPRSet*X + beta*currE;
            pagerankSet(j,:) = currPRSet;
        end
    end
    
    prodVect = zeros(1,seedSetSize);
    for i=1:seedSetSize
        currPR = pagerankSet(i,:);
        sum = 0;
        for j=1:seedSetSize
            sum = sum + currPR(j);
        end
        prodVect(i) = sum;
    end
    
    % Restart set
    maxVal = max(prodVect);
    scrit = find(prodVect == maxVal);
    
    if(length(scrit) == 1)
        index = scrit(1);
        rprScore = pagerankSet(index,:);
    else
      normScrit = norm(scrit);
      summation = 0;
      for i=1:length(scrit)
          currIndex = scrit(i);
          currPR = pagerankSet(currIndex,:);
          summation = summation + currPR;
      end
      rprScore = summation / normScrit;
    end

end

