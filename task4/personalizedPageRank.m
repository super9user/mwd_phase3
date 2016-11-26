function [ pv ] = personalizedPageRank(  )

    X = [[0 1 0 0 0]; [1 0 0 0 0 ]; [0 1 0 0 0]; [0 0 1 0 1]; [0 0 0 1 0]];
    [n, p] = size(X);
    Seed = 1; % Node 1 is a seed node
    alpha = 0.85;
    maxIter = 100;
    
    E = zeros(1,n);
    for i=1:n
        if(i == Seed)
            E(1, i) = 1;
        end
    end
    V = ones(1,n) * 1/n; % Default. Needs to change;

    rowsumvector = ones(1,n) * X';
    nonzerorows = find(rowsumvector);
    zerorows = setdiff(1:n, nonzerorows);
    l = length(zerorows);
    a = sparse(zerorows, ones(l,1), ones(l,1), n, 1); % dangling node vector
    pv=E;

    for i=1:maxIter
        pv = alpha*pv*X + (alpha*(pv*a)+1-alpha)*V;
    end
    
end

