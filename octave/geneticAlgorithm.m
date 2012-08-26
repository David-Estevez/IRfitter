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
	fitness(1,j) = cost( X, y, population( : , j ));
endfor

disp(fitness);

% Main loop
for i=[0:1:iterations]

		

endfor

endfunction
