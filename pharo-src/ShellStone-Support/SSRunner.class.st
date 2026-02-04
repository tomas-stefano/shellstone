"Test runner with colored output for CLI"
Class {
	#name : #SSRunner,
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
SSRunner class >> run [
	^ self new run
]

{ #category : #initialization }
SSRunner >> initialize [
	passed := 0.
	failed := 0.
	pending := 0.
	failures := OrderedCollection new
]

{ #category : #colors }
SSRunner >> green [
	^ Character escape asString, '[32m'
]

{ #category : #colors }
SSRunner >> yellow [
	^ Character escape asString, '[33m'
]

{ #category : #colors }
SSRunner >> red [
	^ Character escape asString, '[31m'
]

{ #category : #colors }
SSRunner >> reset [
	^ Character escape asString, '[0m'
]

{ #category : #running }
SSRunner >> run [
	self runAllSpecs.
	self printResults.
	^ failed
]

{ #category : #running }
SSRunner >> runAllSpecs [
	SSSpecRunner allSubclasses do: [ :specClass |
		specClass buildSuiteFromMethods tests do: [ :test |
			self runTest: test ] ]
]

{ #category : #running }
SSRunner >> runTest: test [
	test currentExample ifNil: [ ^ self ].

	test currentExample isPending
		ifTrue: [ self recordPending ]
		ifFalse: [ self executeTest: test ]
]

{ #category : #running }
SSRunner >> executeTest: test [
	[ test runCase.
	  self recordPass ]
		on: Error, TestFailure
		do: [ :e | self recordFailure: test currentExample error: e ]
]

{ #category : #recording }
SSRunner >> recordPass [
	passed := passed + 1.
	Transcript show: self green, '.', self reset
]

{ #category : #recording }
SSRunner >> recordPending [
	pending := pending + 1.
	Transcript show: self yellow, '*', self reset
]

{ #category : #recording }
SSRunner >> recordFailure: example error: error [
	failed := failed + 1.
	Transcript show: self red, 'F', self reset.
	failures add: { example fullDescription. error messageText }
]

{ #category : #printing }
SSRunner >> printResults [
	Transcript cr; cr.
	self printFailures.
	self printPending.
	self printSummary
]

{ #category : #printing }
SSRunner >> printFailures [
	failures do: [ :f |
		Transcript
			show: self red, 'FAILED: ', self reset, (f at: 1); cr;
			show: '  ', (f at: 2); cr; cr ]
]

{ #category : #printing }
SSRunner >> printPending [
	pending > 0 ifTrue: [
		Transcript show: self yellow, 'Pending: ', pending asString, self reset; cr ]
]

{ #category : #printing }
SSRunner >> printSummary [
	Transcript cr;
		show: passed asString, ' examples, ', failed asString, ' failures'.
	pending > 0 ifTrue: [
		Transcript show: ', ', pending asString, ' pending' ].
	Transcript cr
]
