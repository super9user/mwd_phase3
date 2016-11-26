function [ pv ] = personalizedPageRank(  )

    X = [[0 1 0 0 0]; [1 0 0 0 0 ]; [0 1 0 0 0]; [0 0 1 0 1]; [0 0 0 1 0]];
    [n, ~] = size(X);
    Seed = 1; % Node 1 is a seed node
    beta = 0.15;
    maxIter = 100;
    
    E = zeros(1,n);
    for i=1:n
        if(i == Seed)
            E(1, i) = 1; % This shouldn't be one. Needs to change.
        end
    end
    pv = ones(1,n) * 1/n; % Default (This is biased & sensitive to outliers)

    for i=1:maxIter
        pv = (1 - beta)*pv*X + beta*E;
    end
    
end
