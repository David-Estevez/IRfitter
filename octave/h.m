%=================================================================
% Hypothesis function
%=================================================================

function h = h(x, theta)

% Usually for a linear regression:
%h = X * theta

% For the non-linear function of the IR sensor:
theta0 = theta(1);
theta1 = theta(2);

h = theta0.*(x.^(-theta1));

endfunction
