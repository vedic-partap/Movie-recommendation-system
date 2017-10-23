dimensions = dlmread('data/dimensions.txt');
Y = dlmread('data/Y_matrix.txt');
Y = reshape(Y,dimensions(1)+1,dimensions(2)+1);

my_ratings = zeros(dimensions(1)+1, 1);

% Sample ratings
my_ratings(1) = 4;
my_ratings(98) = 2;
my_ratings(7) = 3;
my_ratings(12)= 5;
my_ratings(54) = 4;
my_ratings(64)= 5;
my_ratings(66)= 3;
my_ratings(69) = 5;
my_ratings(183) = 4;
my_ratings(226) = 5;
my_ratings(355)= 5;

Y = [my_ratings Y];

[Ynorm, Ymean] = normalise(Y);
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
fprintf('Learning starts\n')
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');

p = X * Theta';
my_predictions = p(:,1) + Ymean;
[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for you:\n');
for i=1:10
    j = ix(i)
end