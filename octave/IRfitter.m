%% Fitting IR sensor parameters with several Optimization algoriths
%% Author: David Estévez Fernández
%% Gradient Descend is based on: Stanford University Machine Learning Online Class, exercise #1
%%

%%====================================================================
%Fits the data contained in the file specified in variable path, using 
%algorithm:
% 0 - gradient descend
% 1 - simulated annealing
% 2 - genetic algorithms
% 3 - particle swarm optimization
%=====================================================================

function theta = IRfitter( file , algorithm )

%%Clears system
close all; clc

%%Loads data
fprintf("Loading data... \n");
[X y m] = loadData( file );

%%Plots data (for 1 variable version)
n = size(X, 2);

if n == 1
	fprintf("Plotting data ...\n");
	figure (1);
	plot( X, y, 'rx', 'MarkerSize', 10);
	xlabel('X');
	ylabel('y');
endif 


if algorithm == 0
	%Applies gradientDescend
	theta = [1; 1]; %Initial theta guess
	alpha = 0.0001;	%Learning rate
	iterations = 100000; %number of iterations

	theta = gradientDescend( X, y , theta, alpha, iterations);
endif

%%Plots cost vs iteration (for feedback) 
%% --> If this can be made each iteration it would be better

%%Plots prediction in first picture & returns theta vector
if n == 1
	x = [ 10:0.1:100];
	fprintf("Plotting adjusted function ...\n");
	figure (1);
	hold on;
	plot( x, h(x, theta), 'b-');
	hold off;
	
endif 

endfunction
