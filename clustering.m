load('users.mat');

K = 10;
num_of_features = 19;
max_iters = 10;
num_of_users =  size(users,2);

pos = normrnd(0,1,10,19);

for i=1:max_iters
    fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    idx = closestCentroids(users, pos,K);
    pos = computeCentroids(users, idx, K);
end
save clusters.mat pos