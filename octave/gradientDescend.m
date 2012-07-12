%=================================================================
% Gradient Descend algorithm for IR data fitting
%=================================================================

function theta = gradientDescend( X, y, theta, alpha, iterations)

[m n] = size(X);
aux = zeros(length(theta), 1);
figure;

for i=[0:1:iterations]
%Main loop

%Calculate new values of theta
aux(1) = theta(1) - alpha / m * sum( (h(X, theta)-y).* X.^(-theta(2)) );
aux(2) = theta(2) - alpha / m * sum( (h(X, theta)-y).* (-theta(1).* theta(2) ).* X.^(-(theta(2)+1)) );

%Simultaneous update
theta = aux;

%Plotting cost function for feedback
plot( i, cost(X, y, theta), 'bx', 'MarkerSize', 10);
hold on;
endfor

hold off;
endfunction
	
