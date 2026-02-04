"Command line handler for running ShellStone specs"
Class {
	#name : #SSCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'ShellStone-Support'
}

{ #category : #accessing }
SSCommandLineHandler class >> commandName [
	^ 'shellstone'
]

{ #category : #accessing }
SSCommandLineHandler class >> description [
	^ 'Run ShellStone specs'
]

{ #category : #activation }
SSCommandLineHandler >> activate [
	self activateHelp ifTrue: [ ^ self ].

	self runSpecs.

	self exitSuccess
]

{ #category : #activation }
SSCommandLineHandler >> runSpecs [
	| failures |
	failures := SSRunner run.
	failures > 0 ifTrue: [ self exitFailure: 'Tests failed' ]
]

{ #category : #activation }
SSCommandLineHandler >> activateHelp [
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
SSCommandLineHandler >> printHelp [
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
