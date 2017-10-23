function [J, grad] = cofiCostFunc(params, Y, num_users, num_movies, ...
                                  num_features, lambda)

	X = reshape(params(1:num_movies*num_features), num_movies, num_features);
	Theta = reshape(params(num_movies*num_features+1:end), ...
	                num_users, num_features);

	J = 0;
	X_grad = zeros(size(X));
	Theta_grad = zeros(size(Theta));

	for i=1:size(Y,1)
		for j=1:size(Y,2)
			if Y(i,j)~=0
				J+=(Theta(j,:)*X(i,:)' - Y(i,j))^2;
			end
		end
	end
	J/=2;
	J+= (lambda /2) * (sum(sum(Theta.^2)) + sum(sum(X.^2)));

	for i=1:size(X,1)
		idx = find(Y(i, :)~=0);
		Theta_temp = Theta(idx, :);
		Y_temp = Y(i, idx);
		X_grad (i, :) = (X(i, :) * Theta_temp' - Y_temp ) * Theta_temp;
	end
	X_grad .+= lambda .* X;
	for i=1:size(Theta,1)
		idx = find(Y(:, i)~=0);
		X_temp = X(idx, :);
		Y_temp = Y(idx,i);
		temp =  (X_temp * Theta(i,:)' - Y_temp ) ;
		Theta_grad (i, :) = temp' * X_temp;
	end
	Theta_grad .+= lambda .* Theta;


	% =============================================================

	grad = [X_grad(:); Theta_grad(:)];

end
