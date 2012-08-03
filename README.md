IRfitter
===========

Use several algorithms to fit some experimental data obtained with a IR sensor to a curve in order to make predictions and extract lengths from voltage values.

 * Author: [David Estévez-Fernández](http://github.com/David-Estevez)
 * Released under GPL license , Jul 2012

0. Index
----------------------------------------------------------------------
 * 1.Introduction
 * 2.Dependencies 
 * 3.Algorithms implemented
 * 4.Usage

1. Introduction
----------------------------------------------------------------------
IRfitter is a software that runs on octave and allows you to fit the experimental data 
obtained from a SHARP IR sensor to the curve y = a * x^-b.

Obtaining the inverse of this function one can find the distance to an obstacle from the 
voltage value given by the sensor.

2. Dependencies
----------------------------------------------------------------------
In order to use the IRfitter software you have to have octave installed on your 
computer. Check [octave](http://www.gnu.org/software/octave/download.html) for more
info.

3. Algorithms implemented
----------------------------------------------------------------------
Currently the following algorithms are implemented:
 * Gradient descend
 * Simulated Annealing

Support for the following ones is to be added:
 * Genetic algorithms
 * Particle swarm optimization

4. Usage
------------------------------------------------------------------------
* For using the IRfitter first run octave in a terminal. 

* Then, you have to be working on the octave directory of the IRfitter software.
In octave, you change the current directory using the cd command:

`cd yourPath/octave`

* Now you can call the function IRfitter:

`IRfitter( 'pathToData/file.txt' , index);`

Where the first argument is the path to the data file and the second one is a number indicating 
the chosen algoritm (i.e. 1 for gradient descend, 2 for simulated annealing, etc).

