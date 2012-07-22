%=================================================================
% Gradient Descend algorithm for IR data fitting
%=================================================================

function theta = simulatedAnnealing( X, y, theta, T0, Tf, iterations)

%Parameters:
%============================
% X, y -> data to fit
% theta -> parameter to find
% T0 -> initial temperature
% Tf -> final temperature
% iterations
%----------------------------


alpha = 2;				% Maximum distance of random displacement:
m = length(y );				% Number of training examples
n = length(theta);			% Number of parameters of objective function
initialCost = cost( X, y, theta);	% Initial cost of guessed theta

%Define cooling schedule
%========================================================
temp = T0;


%Main loop
%========================================================
n = 0;
while (temp < Tf && n < iterations)

	%New random movement:
	theta = theta + alpha * (0.5*ones(size(theta)) - rand(size(theta));

	%Cost to move to that position:
	currentCost = cost( X, y, theta);
	costMove= currentCost - initialCost;

	if acceptMovement( costMove, temp)
				
	endif

endwhile

function value = acceptMovement( cost, temp)

end function


endfunction
