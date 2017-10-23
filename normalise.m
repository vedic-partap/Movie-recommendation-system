function [Ynorm, Ymean] = normalise(Y)
%NORMALIZERATINGS Preprocess data by subtracting mean rating for every 
%movie (every row)
%   [Ynorm, Ymean] = NORMALIZERATINGS(Y, R) normalized Y so that each movie
%   has a rating of 0 on average, and returns the mean rating in Ymean.
%

[m, n] = size(Y);
Ymean = zeros(m, 1);
Ynorm = zeros(size(Y));
for i = 1:m
    idx = find(Y(i, :) ~= 0);

    % skip if no data is present. This needs a fix
    if(size(idx,2)~=0)
	    Ymean(i) = mean(Y(i, idx));
	    Ynorm(i, idx) = Y(i, idx) - Ymean(i);
    end
end

end
