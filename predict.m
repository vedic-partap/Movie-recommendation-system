function[cluster_of_movie]=predict()
	no_of_movies = 500;
	load ('clusters.mat');
	load ('users.mat');
	load ('Y_matrix1.mat');

	K=10;
	closestCentroids = closestCentroids(users, pos,K);
	% cluster_of_movie.(num2str(0)) = 0;
	no_of_users = size(Y,2);
	Y = Y(1:no_of_movies,:);
	for i=1:no_of_users
		i
		for j = 1:no_of_movies
			rating = Y(j,i);
			if rating>4
				try
					cluster_of_movie.(num2str(closestCentroids(i))) = [cluster_of_movie.(num2str(closestCentroids(i))) j];
				catch
					cluster_of_movie.(num2str(closestCentroids(i))) = [j];
				end
			end
		end
	end
	for i = 1:10
		cluster_of_movie.(num2str(i)) = unique(cluster_of_movie.(num2str(i)));
	end
	% cluster_of_movie.(num2str(0)) = [];
	save movie_cluster.mat cluster_of_movie
end
