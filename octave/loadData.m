%%=====================================================================
%%Loads the datafile of 'path' and stores it on X matrix and y vector X
%%=====================================================================

function [X y m] = loadData( file )

%%Load the data to a temporal matrix
tmp = load( file );

%%Obtain the size of the matrix (m x n matrix)
[m n] = size(tmp);

%%Obtain X matrix and y vector (last column of tmp)
X = tmp(:, 1:n-1);
y = tmp(:, n);

endfunction


