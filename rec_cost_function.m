function [J, grad] = rec_cost_function(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

htheta=X*theta;
J+=sum((1/(2*m))*((htheta-y).^2));
   

J+=(1/(2*m))*lambda*sum(theta.^2)-(1/(2*m))*lambda*theta(1)^2;
grad=(1/m)*(((htheta-y)'*X)') +(1/m)*lambda*theta;
grad(1)-=(1/m)*lambda*theta(1);

% =============================================================

end
