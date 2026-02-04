"Message expectation for should_receive"
Class {
	#name : #ShMessageExpectation,
	#superclass : #Object,
	#instVars : [
		'double',
		'selector',
		'expectedArgs',
		'returnValue',
		'expectedCount',
		'receivedCalls'
	],
	#category : #'ShellStone-Mocks'
}

{ #category : #'instance creation' }
ShMessageExpectation class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShMessageExpectation >> initialize [
	expectedArgs := nil.
	returnValue := nil.
	expectedCount := nil.  "nil means at least once"
	receivedCalls := OrderedCollection new
]

{ #category : #accessing }
ShMessageExpectation >> double [
	^ double
]

{ #category : #accessing }
ShMessageExpectation >> double: aDouble [
	double := aDouble
]

{ #category : #accessing }
ShMessageExpectation >> selector [
	^ selector
]

{ #category : #accessing }
ShMessageExpectation >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
ShMessageExpectation >> expectedArgs [
	^ expectedArgs
]

{ #category : #accessing }
ShMessageExpectation >> expectedArgs: anArray [
	expectedArgs := anArray
]

{ #category : #accessing }
ShMessageExpectation >> returnValue [
	^ returnValue
]

{ #category : #accessing }
ShMessageExpectation >> returnValue: aValue [
	returnValue := aValue
]

{ #category : #accessing }
ShMessageExpectation >> expectedCount [
	^ expectedCount
]

{ #category : #accessing }
ShMessageExpectation >> receivedCalls [
	^ receivedCalls
]

{ #category : #chaining }
ShMessageExpectation >> withArgs: anArray [
	expectedArgs := anArray.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> withNoArgs [
	expectedArgs := #().
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> andReturn: aValue [
	returnValue := aValue.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> once [
	expectedCount := 1.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> twice [
	expectedCount := 2.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> times: aCount [
	expectedCount := aCount.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> never [
	expectedCount := 0.
	^ self
]

{ #category : #chaining }
ShMessageExpectation >> atLeastOnce [
	expectedCount := nil.  "default behavior"
	^ self
]

{ #category : #recording }
ShMessageExpectation >> recordCall: args [
	receivedCalls add: args
]

{ #category : #verification }
ShMessageExpectation >> verify [
	| actualCount |
	actualCount := receivedCalls size.

	"Check count"
	expectedCount isNil ifTrue: [
		"At least once"
		actualCount < 1 ifTrue: [
			(ShExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' at least once, but received it ', actualCount printString, ' times';
				signal
		]
	] ifFalse: [
		actualCount ~= expectedCount ifTrue: [
			(ShExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' ', expectedCount printString, ' time(s), but received it ', actualCount printString, ' time(s)';
				signal
		]
	].

	"Check args if specified"
	(expectedArgs notNil and: [ receivedCalls notEmpty ]) ifTrue: [
		(receivedCalls anySatisfy: [ :args | args = expectedArgs ]) ifFalse: [
			(ShExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' with ', expectedArgs printString;
				signal
		]
	]
]

{ #category : #verification }
ShMessageExpectation >> matched [
	"Check if expectation was satisfied (for partial verification)"
	| actualCount |
	actualCount := receivedCalls size.

	expectedCount isNil ifTrue: [
		actualCount < 1 ifTrue: [ ^ false ]
	] ifFalse: [
		actualCount ~= expectedCount ifTrue: [ ^ false ]
	].

	(expectedArgs notNil and: [ receivedCalls notEmpty ]) ifTrue: [
		(receivedCalls anySatisfy: [ :args | args = expectedArgs ]) ifFalse: [ ^ false ]
	].

	^ true
]
