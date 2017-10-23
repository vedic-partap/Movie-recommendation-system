function centroids = computeCentroids(X, idx, K)
X=X';
[m n] = size(X);

centroids = zeros(K, n);

for i=1:size(centroids,1)
	sum=zeros(1,size(centroids,2));
	count=0;
	for j=1:length(idx)
		if idx(j)==i
			sum+=X(j,:);
			count+=1;
		end
	end
	if count~=0
		centroids(i,:)=sum./count;
	end
end







% =============================================================


end

