load('X_mov_feat.mat');
load('Y_matrix1.mat');
no_of_movies = 500;
fprintf('Only 500 movies now\n');
Y = Y(1:no_of_movies,:);
cost = 0;
	% n = input ('How many movies do you want to rate ? ');
	% X_new = zeros(n,size(X,2));
	% rating = zeros(n);
	% for i=1:n
	% 	id = input ('Enter movie id: ');
	% 	rate = input ('Enter rating: ');
	% 	X_new(i) = X(id,:);
	% 	rating(i) = rate;
	% end
no_of_users = size(Y,2);
users = zeros (no_of_users,19);
% pos = normrnd(0,1,1,size(X,2));

% while (1)
% 	cost_array = zeros(1,size(X,2));
% 	for i=1:n
% 		cost_array += abs(X_new(i,:) - pos);
% 	end
% 	cost = sum(cost_array);
% end

for i=1:no_of_movies
	i
	feature = X(i,:);
	for j=1:no_of_users
		% printf('a\n')
		rating = Y(i,j);
		if rating>=3
			rating-=2;
		else
			rating-=3;
		end
		if rating==-3
			continue;
		end
		for k = 1:19
			if X(i,k)>0
				users(j,k)+=rating*X(i,k);
				% rating
				% rating*X(i,k)
			end
		end
	end
end
users=users';
for i=1:no_of_users
	maxi = max(users(:,i));
	mini = min(users(:,i));
	for k = 1:size(users(:,i),1)
		if users(k,i)>0
			users(k,i)/=maxi;
		elseif users(k,i)<0
			users(k,i)/=-mini;
		end
	end
end
save users.mat users