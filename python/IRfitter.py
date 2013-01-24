#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Adjust experimental data to the IR curve """

import sys
from PyQt4 import QtGui, QtCore


class IRfitterWindow( QtGui.QWidget ):
	def __init__(self):
		"""
			Main window constructor
		"""
		# Call parent constuctor:
		super( IRfitterWindow, self).__init__()

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
		#self.statusBar().showMessage( 'Press \'Load data\' to start')

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

		self.setLayout( mainVBox )
		
		self.setGeometry( 300, 300, 400, 200)
		self.setWindowTitle( 'IRfitter')
		self.show()

	def loadFile(self):
		file_path = QtGui.QFileDialog.getOpenFileName(self, 'Open file', './', '*.txt' )
		print file_path

def main():
    
    app = QtGui.QApplication(sys.argv)
    win = IRfitterWindow()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()

