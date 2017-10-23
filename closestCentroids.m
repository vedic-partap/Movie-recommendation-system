function idx = closestCentroids(X, centroids,K)
X=X';
idx = zeros(size(X,1), 1);
for i=1:length(idx)
	current=X(i,:);
	pos=1;
	out_dist=sum((current-centroids(1,:)).^2);
	for j=2:K
		dista=sum((current-centroids(j,:)).^2);
		if dista<out_dist
			out_dist=dista;
			pos=j;
		end
	end
	idx(i)=pos;
end

end