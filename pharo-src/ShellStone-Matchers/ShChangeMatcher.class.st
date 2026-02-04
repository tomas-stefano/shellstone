"Change matcher - test that a block changes a value"
Class {
	#name : #ShChangeMatcher,
	#superclass : #ShBaseMatcher,
	#instVars : [
		'receiver',
		'handler',
		'valueBefore',
		'valueAfter',
		'byAmount',
		'fromValue',
		'toValue'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShChangeMatcher class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShChangeMatcher >> initialize [
	super initialize.
	byAmount := nil.
	fromValue := nil.
	toValue := nil
]

{ #category : #accessing }
ShChangeMatcher >> receiver [
	^ receiver
]

{ #category : #accessing }
ShChangeMatcher >> receiver: aBlock [
	receiver := aBlock
]

{ #category : #accessing }
ShChangeMatcher >> handler [
	^ handler
]

{ #category : #accessing }
ShChangeMatcher >> handler: aHandler [
	handler := aHandler
]

{ #category : #chaining }
ShChangeMatcher >> by: anAmount [
	byAmount := anAmount.
	^ self verify
]

{ #category : #chaining }
ShChangeMatcher >> from: aValue [
	fromValue := aValue.
	^ self
]

{ #category : #chaining }
ShChangeMatcher >> to: aValue [
	toValue := aValue.
	^ self verify
]

{ #category : #chaining }
ShChangeMatcher >> from: startValue to: endValue [
	fromValue := startValue.
	toValue := endValue.
	^ self verify
]

{ #category : #chaining }
ShChangeMatcher >> verify [
	"Execute and verify the change"
	^ handler handleMatcher: self
]

{ #category : #matching }
ShChangeMatcher >> matches: actualBlock [
	"actualBlock is the block being tested (actual)"
	"receiver is the block that produces the value to check"
	valueBefore := receiver value.
	actualBlock value.
	valueAfter := receiver value.

	"Check from value if specified"
	(fromValue notNil and: [ valueBefore ~= fromValue ]) ifTrue: [ ^ false ].

	"Check to value if specified"
	(toValue notNil and: [ valueAfter ~= toValue ]) ifTrue: [ ^ false ].

	"Check by amount if specified"
	byAmount notNil ifTrue: [
		^ (valueAfter - valueBefore) = byAmount
	].

	"Just check that value changed"
	^ valueBefore ~= valueAfter
]

{ #category : #messages }
ShChangeMatcher >> positiveFailureMessage [
	byAmount notNil ifTrue: [
		^ 'expected value to change by ', byAmount printString,
			' but changed from ', valueBefore printString, ' to ', valueAfter printString,
			' (difference: ', (valueAfter - valueBefore) printString, ')'
	].
	(fromValue notNil and: [ toValue notNil ]) ifTrue: [
		^ 'expected value to change from ', fromValue printString, ' to ', toValue printString,
			' but changed from ', valueBefore printString, ' to ', valueAfter printString
	].
	fromValue notNil ifTrue: [
		^ 'expected value to start at ', fromValue printString, ' but was ', valueBefore printString
	].
	toValue notNil ifTrue: [
		^ 'expected value to change to ', toValue printString, ' but was ', valueAfter printString
	].
	^ 'expected value to change but it stayed ', valueBefore printString
]

{ #category : #messages }
ShChangeMatcher >> negativeFailureMessage [
	^ 'expected value not to change but it changed from ', valueBefore printString, ' to ', valueAfter printString
]

{ #category : #messages }
ShChangeMatcher >> description [
	byAmount notNil ifTrue: [
		^ 'change by ', byAmount printString
	].
	(fromValue notNil and: [ toValue notNil ]) ifTrue: [
		^ 'change from ', fromValue printString, ' to ', toValue printString
	].
	^ 'change'
]
