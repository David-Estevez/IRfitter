#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Adjust experimental data to the IR curve """

# Loading dependencies:
import sys

# Import Qt4
try:
	from PyQt4 import QtGui, QtCore
except ImportError:
	print "Error: PyQt4 not installed."
	exit()
# Import NumPy
try:
	import numpy as np	

except ImportError:
	print "Error: NumPy is not installed"
	exit()

class IRfitterWindow( QtGui.QMainWindow ):
	""" Main Window of the IRfitter program """
	
	def __init__(self):
		"""
			Main window constructor
		"""
		# Call parent constuctor:
		super( IRfitterWindow, self).__init__()

		# Create function to call for loading data / calculate parameters:
		self.calculateParameters = 0

		# Create window:
		self.createGUI()

	def createGUI(self):
		"""
			Defines and creates the main window
		"""
		# Create widgets
		loadButton = QtGui.QPushButton( 'Load data' )
		loadButton.setToolTip( 'Yes, this button' )
		loadButton.clicked.connect( self.loadFile )

		
		quitButton = QtGui.QPushButton( 'Quit')		
		quitButton.setToolTip( 'No, this is for closing the window' )
		quitButton.clicked.connect( QtGui.qApp.quit)

		self.resultLabel = QtGui.QLabel( self.genResultText( None, None) )	

		# Create status bar
		self.statusBar().showMessage( 'Press \'Load data\' to start')

		# Create the layout:
		buttonVBox = QtGui.QVBoxLayout()
		buttonVBox.addWidget( loadButton )
		buttonVBox.addWidget( quitButton )
		buttonVBox.addStretch(1)

		textHBox = QtGui.QHBoxLayout()
		textHBox.addLayout( buttonVBox)
		textHBox.addStretch(1)
		textHBox.addWidget(self.resultLabel)
		textHBox.addStretch(1)

		mainVBox = QtGui.QVBoxLayout()
		mainVBox.addLayout( textHBox )
		mainVBox.addStretch(1)
		
		mainWidget = QtGui.QWidget()
		mainWidget.setLayout( mainVBox )
		
		self.setCentralWidget( mainWidget )

		self.setGeometry( 300, 300, 270, 120)
		self.setWindowTitle( 'IRfitter')
		self.setWindowIcon( QtGui.QIcon('icon.png') )
		self.show()

	def loadFile(self):
		"""
			Action to perform when 'load' button is pressed.
			--------------------------------------------------------
			Loads data from the given path, and calculates the 
			a and b parameters, which are later shown on the window.
		"""
		file_path = QtGui.QFileDialog.getOpenFileName(self, 'Open file', './', '*.txt' )
		a, b = self.calculateParameters( file_path )
		self.statusBar().showMessage( 'Calculations done.')
		self.resultLabel.setText( self.genResultText( a, b) )
		self.resultLabel.adjustSize()

	def linkFunction(self, function):
		"""
			Assigns the function to call for calculating the parameters.
			This function should take as parameter one file path and return
			the values of a and b. 
		"""
		self.calculateParameters = function

	def genResultText(self, a, b):
		""" 
			Generates the text to display in the label. If a and b are not 
			known yet, it displays '??'
		"""
		if a == None:
			a = '??'
		if b == None:
			b = '??'
		return 'Equation to fit:<br> y = a x<sup>b</sup><br><br>a = ' + str(a) + '<br>b = ' + str(b) 



def calculate( file_path):
	"""
		This function should take as parameter one file path and return 
		the values of a and b. 
	"""
	# Load data from given file:
	data = np.loadtxt( str(file_path) )

	# Extract data from loaded data:
	X = data[:, 0]	
	y = np.vstack( data[:, 1] )	
	m = y.size

	# Transform data (log)
	X = np.log(X)
	y = np.log(y)

	# Add a column of 1 and revert back orientation:
	X = (np.vstack( ( np.ones(( 1, m)) , X) ) ).T

	# Create initial guess:
	theta = np.array( [ [ 0 ] , [ 0 ] ] )

	# Fit the data:
	theta = gradientDescend( X, y, theta, 0.001, 60000)

	# Undo the transformation:	
	a = np.exp( theta[0][0] )
	b = - theta[1][0]
 
	print theta
	print a, b	
	return a, b

""" Math functions: """
def gradientDescend( X, y, theta, alpha, iterations):
	m = y.size
	for i in range( 0, iterations):
		theta = theta - (alpha / m ) * np.dot( X.T, np.dot( X, theta) - y)
	return theta

def costFunction( X, y, theta):
	m = y.size
	cost = 1 / (2 * m) *  np.dot( (h(X, theta) - y).T , h(X, theta) - y )
	return cost

def h( X, theta):
	return np.dot( X, theta)
	

""" Main function """
def main():	
	app = QtGui.QApplication(sys.argv)
	win = IRfitterWindow()
	win.linkFunction( calculate )
	sys.exit(app.exec_())


if __name__ == '__main__':
    main()

