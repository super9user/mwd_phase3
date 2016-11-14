function [ allPageRanks ] = pagerank(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    d = 0.85; % Damping Factor
    maxIter = 100;
    
    X = [[0, 1, 1, 0]; [0, 0, 1, 0]; [1, 0, 0, 0]; [0, 0, 1, 0]];
    [n, p] = size(X);
    
    allPageRanks = ones(1,n) * 1/n; % Intialize pagerank values
    
    for i=1:maxIter % Iterate for 'maxIter' times
        for j=1:n % Iterate over all the nodes
            allIncomingEdges = X(:,j); % A column vector denotes all incoming edges
            
            summation = 0;
            for k=1:length(allIncomingEdges) % Iterate over all incoming edges
                edge = allIncomingEdges(k);
                if(edge ~= 0) % Non-zero value, which means edge exists
                   pageRankOfNode = allPageRanks(k);
                   totalOutgoingEdgesFromNode = nnz(X(k,:));
                   summation = summation + (pageRankOfNode / totalOutgoingEdgesFromNode);
                end
            end
            
            newPageRank = ((1-d)) + (d*summation);
            allPageRanks(j) = newPageRank;
        end
    end
end
