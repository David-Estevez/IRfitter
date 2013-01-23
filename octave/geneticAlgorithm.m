%=================================================================
% Simulated annealing algorithm for IR data fitting
%=================================================================

function theta = geneticAlgorithm( X, y, num_guesses, iterations)

% Parameters:
%=====================================================
% num_guesses -> Amount of indiviuals in the population
% iterations -> Number of iterations
%-----------------------------------------------------

theta = zeros(2, 1); 	% Initialize theta to zeros

alpha = 0.60; 		% Influence of each parent in the child
guess = 2;		% Initial population located around 0,0 in a 2x2 square ( x belongs [-1,1], y belongs [-1, 1] )



% Generate random population
population = ( rand(length(theta),num_guesses) - 0.5) * 2 * guess/2;

disp(population);

% Initial evaluation all individuals
fitness = zeros( 1, size(population, 2) );

for j=[1:1:size(population, 2)]
	% Obtain minimization cost:
	fitness(1,j) = cost( X, y, population( : , j ));

	% Transform it to maximization cost:
	fitness = 1 ./ ( 1 .+ fitness);
endfor

disp(fitness); %debug stuff

% Main loop
for i=[0:1:iterations]

	% Sort population
	% -------------------------------------------------------------------
	
	% Sort by cost
	[fitness indexes] = sort( fitness );
	
	% Store ordered vectors in a new array:
	new_population = zeros( size( population, 1), size( population, 2) );
	
	for i = [1:1:size( population, 2)]
		new_population( :, i) = population(:, indexes(i));
	endfor


	% Select parents
	% --------------------------------------------------------------------
	
	
	
endfor

endfunction
