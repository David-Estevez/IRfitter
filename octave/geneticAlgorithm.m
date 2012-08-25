%=================================================================
%Simulated annealing algorithm for IR data fitting
%=================================================================

function theta = geneticAlgorithm( X, y, population, iterations)

%Parameters:
%=====================================================
% population -> Amount of indiviuals in the population
% iterations -> Number of iterations
%-----------------------------------------------------

theta = zeros(2, 1); 	% Initialize theta to zeros
alpha = 0.60; 		% Influence of each parent in the child

endfuction
