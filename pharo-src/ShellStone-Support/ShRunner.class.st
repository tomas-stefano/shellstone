"Test runner with colored output for CLI"
Class {
	#name : #ShRunner,
	#superclass : #Object,
	#instVars : [
		'passed',
		'failed',
		'pending',
		'failures'
	],
	#category : #'ShellStone-Support'
}

{ #category : #running }
ShRunner class >> run [
	^ self new run
]

{ #category : #initialization }
ShRunner >> initialize [
	passed := 0.
	failed := 0.
	pending := 0.
	failures := OrderedCollection new
]

{ #category : #colors }
ShRunner >> green [
	^ Character escape asString, '[32m'
]

{ #category : #colors }
ShRunner >> yellow [
	^ Character escape asString, '[33m'
]

{ #category : #colors }
ShRunner >> red [
	^ Character escape asString, '[31m'
]

{ #category : #colors }
ShRunner >> reset [
	^ Character escape asString, '[0m'
]

{ #category : #running }
ShRunner >> run [
	self runAllSpecs.
	self printResults.
	^ failed
]

{ #category : #running }
ShRunner >> runAllSpecs [
	ShSpecRunner allSubclasses do: [ :specClass |
		specClass buildSuiteFromMethods tests do: [ :test |
			self runTest: test ] ]
]

{ #category : #running }
ShRunner >> runTest: test [
	test currentExample ifNil: [ ^ self ].

	test currentExample isPending
		ifTrue: [ self recordPending ]
		ifFalse: [ self executeTest: test ]
]

{ #category : #running }
ShRunner >> executeTest: test [
	[ test runCase.
	  self recordPass ]
		on: Error, TestFailure
		do: [ :e | self recordFailure: test currentExample error: e ]
]

{ #category : #recording }
ShRunner >> recordPass [
	passed := passed + 1.
	Transcript show: self green, '.', self reset
]

{ #category : #recording }
ShRunner >> recordPending [
	pending := pending + 1.
	Transcript show: self yellow, '*', self reset
]

{ #category : #recording }
ShRunner >> recordFailure: example error: error [
	failed := failed + 1.
	Transcript show: self red, 'F', self reset.
	failures add: { example fullDescription. error messageText }
]

{ #category : #printing }
ShRunner >> printResults [
	Transcript cr; cr.
	self printFailures.
	self printPending.
	self printSummary
]

{ #category : #printing }
ShRunner >> printFailures [
	failures do: [ :f |
		Transcript
			show: self red, 'FAILED: ', self reset, (f at: 1); cr;
			show: '  ', (f at: 2); cr; cr ]
]

{ #category : #printing }
ShRunner >> printPending [
	pending > 0 ifTrue: [
		Transcript show: self yellow, 'Pending: ', pending asString, self reset; cr ]
]

{ #category : #printing }
ShRunner >> printSummary [
	Transcript cr;
		show: passed asString, ' examples, ', failed asString, ' failures'.
	pending > 0 ifTrue: [
		Transcript show: ', ', pending asString, ' pending' ].
	Transcript cr
]
