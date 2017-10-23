load('X_mov_feat.mat')

no_movies=size(X,1);
no_features=size(X,2);

my_ratings = zeros(no_movies, 1);
Y=zeros(11,2); %movIid, rating

movieList = loadMovieList();

my_ratings(1) = 5; Y(1,1)=1; Y(1,2)=5;
my_ratings(98) = 5; Y(2,1)=98; Y(2,2)=5;
my_ratings(7) = 5;  Y(3,1)=7; Y(3,2)=5;
my_ratings(12)= 5;  Y(4,1)=12; Y(4,2)=5;
my_ratings(54) = 5; Y(5,1)=54; Y(5,2)=5;
my_ratings(64)= 5;  Y(6,1)=64; Y(6,2)=5;
my_ratings(66)= 3;  Y(7,1)=66; Y(7,2)=1;
my_ratings(69) = 5; Y(8,1)=69; Y(8,2)=5;
my_ratings(183) = 4; Y(9,1)=183; Y(9,2)=4;
my_ratings(226) = 5; Y(10,1)=226; Y(10,2)=5;
my_ratings(355)= 5;  Y(11,1)=355; Y(11,2)=5;

no_of_movies_rated=sum(my_ratings(:,1)~=0);

initial_theta=randn(1, no_features)'; %'
X1=X(Y(:,1),:);    %X1*theta = Y //rating 

options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
lambda=0.01;
[theta, J, exit_flag] = ...
	fminunc(@(t)(rec_cost_function(t, X1, Y(:,2), lambda)), initial_theta, options); 

fprintf("\n final cost = %f \n",J)

p=X*theta;
p_orig=p;

max_rating=max(Y(:,2));
max_predicted_score=max(p);
p=5-abs(p-5)/max_predicted_score;
[r, ix] = sort(p, 'descend');


fprintf('\nTop recommendations for you:\n');
for i=1:100
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', p(j), ...
            movieList{j});
end

fprintf(" \n Printing predicted in training \n");
for i=1:length(Y(:,1))
	fprintf(" rating for %s should be %0.1f \n",movieList{Y(i,1)}, p_orig(Y(i,1)))
end
my_predictions_training=X1*theta;

fprintf('\n\nmy prediction training ratings provided:\n');
for i = 1:length(my_predictions_training)
        fprintf('Rated %0.1f, %d for %s \n', my_predictions_training(i), ...
                  Y(i,2),movieList{Y(i,1)});
end
