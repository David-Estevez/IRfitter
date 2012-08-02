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


alpha = 500*2;				% Maximum distance of random displacement:
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

	fprintf( "Iteration: %d\n", n);

	%New random movement:
	move = alpha * ( 0.5*ones(size(theta)) - rand(size(theta)) );

	%Cost to move to that position:
	currentCost = cost( X, y, theta+move);
	costMove= currentCost - initialCost;

	if acceptMovement( costMove, temp)
		theta += move;
		initialCost = currentCost;
	endif

endwhile


endfunction

% Function to evaluate if a movement is accepted or not depending on the cost of making that
% movement and the temperature of the system
% ==========================================================================================

function value = acceptMovement( cost, temp)
	if ( cost < 0) || ( cost >= 0 && rand(1) < exp( -cost / temp ) )
		value = true;
	else
		value = false;
	endif
endfunction

function nextTemp = cooling( T0, Tf, currentIter, iterations)

	%Linear cooling
	nextTemp = T0 - ( (T0-Tf) / iterations ) * currentIter;

	%It can also use other cooling expressions

endfunction
