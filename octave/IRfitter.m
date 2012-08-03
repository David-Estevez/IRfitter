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

%Prepare system & load data
%=====================================================================
%%Clear system
close all; clc

%%Load data
fprintf("Loading data... ");
[X y m] = loadData( file );

%Plot raw data
fprintf("[OK]\nPlotting data ...");
figure (1);
plot( X, y, 'rx', 'MarkerSize', 10);
xlabel('X');
ylabel('y');
legend('Training data', 'Fitted expression');
title('Raw data');

%Transform the data
X=log(X);
y=log(y);

%Plot transformed data
fprintf("[OK]\nPlotting data ...");
figure (2);
plot( X, y, 'rx', 'MarkerSize', 10);
xlabel('ln X');
ylabel('ln y');
legend('Training data', 'Linear regression');
title('Transformed data');

%Add one column of ones
X = [ ones( m, 1) X];


%Algorithm selection:
%================================================================
if algorithm == 1
	%Gradient Descend algorithm
	%========================================================
	%Parameters:
	theta =  zeros(2,1); %Initial theta guess
	alpha = 0.001;	%Learning rate
	iterations = 60000; %number of iterations

	%Apply gradiend descend:
	fprintf("[OK]\nApplying gradient descend... ");
	theta = gradientDescend( X, y , theta, alpha, iterations);
endif

if algorithm == 2
	%Simulated annealing algoritm
	%=========================================================
	%Parameters:
	theta = zeros(2,1);	%Initial theta guess
	T0 = 1500;		%Initial temperature
	Tf = 0;			%Final temperature
	iterations = 100000; 	%Number of iterations

	%Apply simulated annealing:
	fprintf("[OK]\nApplying simulated annealing... ");
	theta = simulatedAnnealing( X, y, theta, T0, Tf, iterations);
endif


%Plotting prediction:
%=================================================================
%Plot over transformed data
%-------------------------------
x = [ min(min(X)):0.1:max(max(X))]; %From first data point to last data point
x = [ ones( length(x), 1) x']; %Add a column of ones

fprintf("[OK]\nPlotting adjusted function ...");
figure (2);
hold on;
plot( x(:, 2) , h(x, theta), 'b-');
hold off;

%Display result
fprintf("[OK]\n\n-Theta for y = theta0 * x^theta1 expression:\n\tTheta0 = %f\n\tTheta1 = %f\n", theta(1), theta(2));

%Plot over raw data:
%-------------------------------
x = [ exp( min(min(X)) ):0.1: exp(max(max(X)))]; %From first data point to last one, undo tranformation

%Transform theta
theta(1) =  exp( theta(1) );
theta(2) = -theta(2);

fprintf("\nPlotting adjusted function... ");
figure (1);
hold on;
plot( x, theta(1).*x.^(-theta(2)), 'b-');
hold off;

%Display result
fprintf("[OK]\n\nTheta for ln y = theta1 * ln x + theta0 expression:\n\tTheta0 = %f\n\tTheta1 = %f\n\n", theta(1), theta(2));

