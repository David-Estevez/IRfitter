#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Adjust experimental data to the IR curve """

import sys
from PyQt4 import QtGui, QtCore


class IRfitterWindow( QtGui.QMainWindow ):
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
		#loadButton.resize( loadButton.sizeHint() )
		loadButton.clicked.connect( self.loadFile )
		
		quitButton = QtGui.QPushButton( 'Quit')		
		#quitButton.resize( quitButton.sizeHint() )
		quitButton.clicked.connect( QtGui.qApp.quit)

		resultLabel = QtGui.QLabel('Equation to fit:<br> y = a x<sup>b</sup><br>a = ??<br>b = ??')
		#resultLabel.resize( resultLabel.sizeHint() )

		# Create status bar
		self.statusBar().showMessage( 'Press \'Load data\' to start')

		# Create the layout:
		buttonVBox = QtGui.QVBoxLayout()
		buttonVBox.addWidget( loadButton )
		buttonVBox.addWidget( quitButton )

		textHBox = QtGui.QHBoxLayout()
		textHBox.addLayout( buttonVBox)
		textHBox.addStretch(1)
		textHBox.addWidget(resultLabel)
		textHBox.addStretch(1)

		mainVBox = QtGui.QVBoxLayout()
		mainVBox.addLayout( textHBox )
		mainVBox.addStretch(1)

		mainWidget = QtGui.QWidget()
		mainWidget.setLayout( mainVBox )
		
		self.setCentralWidget( mainWidget )

		self.setGeometry( 300, 300, 270, 120)
		self.setWindowTitle( 'IRfitter')
		self.show()

	def loadFile(self):
		file_path = QtGui.QFileDialog.getOpenFileName(self, 'Open file', './', '*.txt' )
		self.calculateParameters( file_path )

	def linkFunction(self, function):
		self.calculateParameters = function

def calculate( file_path):
	print file_path

def main():
	app = QtGui.QApplication(sys.argv)
	win = IRfitterWindow()
	win.linkFunction( calculate )
	sys.exit(app.exec_())


if __name__ == '__main__':
    main()

