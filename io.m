% load ('movie_cluster.mat')
load ('X_mov_feat.mat');
load ('clusters.mat')
n = input ('How many movies do you want to rate ? ');
X_new = zeros(n,size(X,2));
rating = zeros(n);
for i=1:n
	id = input ('Enter movie id: ');
	rate = input ('Enter rating: ');
	X_new(i,:) = X(id,:);
	rating(i) = rate;
end
cluster_of_movie = predict()

user_vector = zeros(1,19);
for i=1:n
	i
	feature = X_new(i,:);
	rating_here = rating(i);
	if rating_here>=3
		rating_here-=2;
	else
		rating_here-=3;
	end
	if rating_here==-3
		continue;
	end
	for k = 1:19
		if X_new(i,k)>0
			user_vector(k)+=rating_here*X_new(i,k);
		end
	end
end

maxi = max(user_vector);
mini = min(user_vector);
for k = 1:19
	if user_vector(k)>0
		user_vector(k)/=maxi;
	elseif user_vector(k)<0
		user_vector(k)/=-mini;
	end
end

user_vector
K=10;

% arr = [zeros(1,19); user_vector]
cluster_here = closestCentroids([user_vector]', pos,K);
movie_ids = cluster_of_movie.(num2str(cluster_here))
distance = zeros(size(movie_ids));
for i=1:size(movie_ids,2)
	current = X(movie_ids(i),:);
	centroid = X(cluster_here);
	for j = 1:19
		if user_vector(j)==0
			distance(i) += current(j);
		end
	end
end
% movie_ids = cluster_of_movie.(num2str(cluster_here))
net = [distance; movie_ids]
net = sortrows(net.',1).' 
final_movie_ids = net(2,:);
% data = csvread( 'data/ratings.csv' )
save final_movie_ids.mat final_movie_ids