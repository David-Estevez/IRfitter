%=================================================================
% Gradient Descend algorithm for IR data fitting
%=================================================================

function theta = gradientDescend( X, y, theta, alpha, iterations)

m  = length(y);
history = zeros(1, iterations+1);

%Main loop
%==================================================================
for ind=[1:1:iterations+1]

%Calculate new values of theta
theta = theta - (alpha / m) .*  X' * (X*theta - y);

%Save cost for each iteration:
history(ind) = cost(X, y, theta);

endfor

%Plotting cost function for feedback
%==================================================================
figure;
plot( [0:1:iterations], history, 'bx', 'MarkerSize', 1);
xlabel('Iteration'); ylabel('Cost'); title('Cost evolution');

endfunction
	
