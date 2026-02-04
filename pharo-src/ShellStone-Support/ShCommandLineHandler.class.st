"Command line handler for running ShellStone specs"
Class {
	#name : #ShCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'ShellStone-Support'
}

{ #category : #accessing }
ShCommandLineHandler class >> commandName [
	^ 'shellstone'
]

{ #category : #accessing }
ShCommandLineHandler class >> description [
	^ 'Run ShellStone specs'
]

{ #category : #activation }
ShCommandLineHandler >> activate [
	self activateHelp ifTrue: [ ^ self ].

	self runSpecs.

	self exitSuccess
]

{ #category : #activation }
ShCommandLineHandler >> runSpecs [
	| failures |
	failures := ShRunner run.
	failures > 0 ifTrue: [ self exitFailure: 'Tests failed' ]
]

{ #category : #activation }
ShCommandLineHandler >> activateHelp [
	(self hasOption: 'help') ifTrue: [
		self printHelp.
		self exitSuccess.
		^ true
	].
	(self hasOption: 'version') ifTrue: [
		self stdout nextPutAll: 'ShellStone 0.1.0'; lf.
		self exitSuccess.
		^ true
	].
	^ false
]

{ #category : #printing }
ShCommandLineHandler >> printHelp [
	self stdout
		nextPutAll: 'ShellStone - RSpec-inspired testing for Pharo'; lf;
		lf;
		nextPutAll: 'Usage: pharo Pharo.image shellstone [options]'; lf;
		lf;
		nextPutAll: 'Options:'; lf;
		nextPutAll: '  --help       Show this help'; lf;
		nextPutAll: '  --version    Show version'; lf;
		lf;
		nextPutAll: 'Example:'; lf;
		nextPutAll: '  ./pharo Pharo.image shellstone'; lf
]
