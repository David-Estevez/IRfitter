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


alpha = 0.0015*2;			% Maximum distance of random displacement

m = length(y );				% Number of training examples
n = length(theta);			% Number of parameters of objective function
initialCost = cost( X, y, theta);	% Initial cost of guessed theta

history = zeros(1, iterations+1);	% Store cost history
temp_history = zeros(1, iterations+1);	% Store temperature history

%Define cooling schedule 
%========================================================
temp = T0;

geo_cool = 0.9995;			% Uncomment for geometric cooling, 0 > value > 1

%Main loop
%========================================================
n = 0;

while (temp > Tf && n < iterations)

	%New random movement:
	move = alpha * ( 0.5*ones(size(theta)) - rand(size(theta)) );

	%Cost to move to that position:
	currentCost = cost( X, y, theta+move);
	costMove= currentCost - initialCost;

	%If it fulfills the requirements is accepted:
	if acceptMovement( costMove, temp)
		theta += move;
		initialCost = currentCost;
	endif

	%Save cost for each iteration:
	history(n+1) = cost(X, y, theta);

	%Cooling
	%======================================================
	%Linear cooling
	%temp = T0 - ( (T0-Tf) / iterations ) * n;

	%Geometric cooling (for me it works better than linear cooling):
	temp = T0 * (geo_cool)^n;
	
	%Save temperature for each iteration:
	temp_history(n+1) = temp;

	%Increment counter:
	n++;
endwhile

%Plotting cost function for feedback
%==================================================================
figure;
plot( [0:1:iterations], history, 'bx', 'MarkerSize', 1);
xlabel('Iteration'); ylabel('Cost'); title('Cost evolution');

%Plotting temperature evolution for feedback
%==================================================================
figure;
plot( [0:1:iterations], temp_history, 'bx', 'MarkerSize', 1);
xlabel('Iteration'); ylabel('Temperature'); title('Temperature evolution');
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

