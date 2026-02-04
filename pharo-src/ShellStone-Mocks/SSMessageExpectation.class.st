"Message expectation for should_receive"
Class {
	#name : #SSMessageExpectation,
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
SSMessageExpectation class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSMessageExpectation >> initialize [
	expectedArgs := nil.
	returnValue := nil.
	expectedCount := nil.  "nil means at least once"
	receivedCalls := OrderedCollection new
]

{ #category : #accessing }
SSMessageExpectation >> double [
	^ double
]

{ #category : #accessing }
SSMessageExpectation >> double: aDouble [
	double := aDouble
]

{ #category : #accessing }
SSMessageExpectation >> selector [
	^ selector
]

{ #category : #accessing }
SSMessageExpectation >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
SSMessageExpectation >> expectedArgs [
	^ expectedArgs
]

{ #category : #accessing }
SSMessageExpectation >> expectedArgs: anArray [
	expectedArgs := anArray
]

{ #category : #accessing }
SSMessageExpectation >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SSMessageExpectation >> returnValue: aValue [
	returnValue := aValue
]

{ #category : #accessing }
SSMessageExpectation >> expectedCount [
	^ expectedCount
]

{ #category : #accessing }
SSMessageExpectation >> receivedCalls [
	^ receivedCalls
]

{ #category : #chaining }
SSMessageExpectation >> withArgs: anArray [
	expectedArgs := anArray.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> withNoArgs [
	expectedArgs := #().
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> andReturn: aValue [
	returnValue := aValue.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> once [
	expectedCount := 1.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> twice [
	expectedCount := 2.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> times: aCount [
	expectedCount := aCount.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> never [
	expectedCount := 0.
	^ self
]

{ #category : #chaining }
SSMessageExpectation >> atLeastOnce [
	expectedCount := nil.  "default behavior"
	^ self
]

{ #category : #recording }
SSMessageExpectation >> recordCall: args [
	receivedCalls add: args
]

{ #category : #verification }
SSMessageExpectation >> verify [
	| actualCount |
	actualCount := receivedCalls size.

	"Check count"
	expectedCount isNil ifTrue: [
		"At least once"
		actualCount < 1 ifTrue: [
			(SSExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' at least once, but received it ', actualCount printString, ' times';
				signal
		]
	] ifFalse: [
		actualCount ~= expectedCount ifTrue: [
			(SSExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' ', expectedCount printString, ' time(s), but received it ', actualCount printString, ' time(s)';
				signal
		]
	].

	"Check args if specified"
	(expectedArgs notNil and: [ receivedCalls notEmpty ]) ifTrue: [
		(receivedCalls anySatisfy: [ :args | args = expectedArgs ]) ifFalse: [
			(SSExpectationFailed new)
				messageText: 'Expected ', double name, ' to receive #', selector asString, ' with ', expectedArgs printString;
				signal
		]
	]
]

{ #category : #verification }
SSMessageExpectation >> matched [
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
