"Change matcher - test that a block changes a value"
Class {
	#name : #SSChangeMatcher,
	#superclass : #SSBaseMatcher,
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
SSChangeMatcher class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSChangeMatcher >> initialize [
	super initialize.
	byAmount := nil.
	fromValue := nil.
	toValue := nil
]

{ #category : #accessing }
SSChangeMatcher >> receiver [
	^ receiver
]

{ #category : #accessing }
SSChangeMatcher >> receiver: aBlock [
	receiver := aBlock
]

{ #category : #accessing }
SSChangeMatcher >> handler [
	^ handler
]

{ #category : #accessing }
SSChangeMatcher >> handler: aHandler [
	handler := aHandler
]

{ #category : #chaining }
SSChangeMatcher >> by: anAmount [
	byAmount := anAmount.
	^ self verify
]

{ #category : #chaining }
SSChangeMatcher >> from: aValue [
	fromValue := aValue.
	^ self
]

{ #category : #chaining }
SSChangeMatcher >> to: aValue [
	toValue := aValue.
	^ self verify
]

{ #category : #chaining }
SSChangeMatcher >> from: startValue to: endValue [
	fromValue := startValue.
	toValue := endValue.
	^ self verify
]

{ #category : #chaining }
SSChangeMatcher >> verify [
	"Execute and verify the change"
	^ handler handleMatcher: self
]

{ #category : #matching }
SSChangeMatcher >> matches: actualBlock [
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
SSChangeMatcher >> positiveFailureMessage [
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
SSChangeMatcher >> negativeFailureMessage [
	^ 'expected value not to change but it changed from ', valueBefore printString, ' to ', valueAfter printString
]

{ #category : #messages }
SSChangeMatcher >> description [
	byAmount notNil ifTrue: [
		^ 'change by ', byAmount printString
	].
	(fromValue notNil and: [ toValue notNil ]) ifTrue: [
		^ 'change from ', fromValue printString, ' to ', toValue printString
	].
	^ 'change'
]
