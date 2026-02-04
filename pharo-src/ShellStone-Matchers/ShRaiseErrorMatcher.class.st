"RaiseError matcher - exception testing"
Class {
	#name : #ShRaiseErrorMatcher,
	#superclass : #ShBaseMatcher,
	#instVars : [
		'raisedException',
		'expectedMessage'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShRaiseErrorMatcher class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
ShRaiseErrorMatcher class >> expected: anExceptionClass [
	^ self new expected: anExceptionClass; yourself
]

{ #category : #'instance creation' }
ShRaiseErrorMatcher class >> expected: anExceptionClass message: aString [
	^ self new
		expected: anExceptionClass;
		expectedMessage: aString;
		yourself
]

{ #category : #initialization }
ShRaiseErrorMatcher >> initialize [
	super initialize.
	expected := Exception.
	raisedException := nil
]

{ #category : #accessing }
ShRaiseErrorMatcher >> expectedMessage [
	^ expectedMessage
]

{ #category : #accessing }
ShRaiseErrorMatcher >> expectedMessage: aString [
	expectedMessage := aString
]

{ #category : #accessing }
ShRaiseErrorMatcher >> raisedException [
	^ raisedException
]

{ #category : #matching }
ShRaiseErrorMatcher >> matches: actualValue [
	"actualValue should be a block"
	[
		actualValue value.
		"No exception raised"
		raisedException := nil.
		^ false
	] on: Exception do: [ :ex |
		raisedException := ex.
		"Check if it's the expected type"
		(ex isKindOf: expected) ifFalse: [ ^ false ].
		"Check message if specified"
		expectedMessage isNil ifTrue: [ ^ true ].
		^ ex messageText = expectedMessage
	]
]

{ #category : #messages }
ShRaiseErrorMatcher >> positiveFailureMessage [
	raisedException isNil ifTrue: [
		^ 'expected block to raise ', expected name, ' but nothing was raised'
	].
	(raisedException isKindOf: expected) ifFalse: [
		^ 'expected block to raise ', expected name, ' but ', raisedException class name, ' was raised'
	].
	expectedMessage isNil ifFalse: [
		^ 'expected exception with message ''', expectedMessage, ''' but got ''', raisedException messageText, ''''
	].
	^ 'expected block to raise ', expected name
]

{ #category : #messages }
ShRaiseErrorMatcher >> negativeFailureMessage [
	^ 'expected block not to raise ', expected name, ' but it did'
]

{ #category : #messages }
ShRaiseErrorMatcher >> description [
	expectedMessage isNil
		ifTrue: [ ^ 'raise ', expected name ]
		ifFalse: [ ^ 'raise ', expected name, ' with message ''', expectedMessage, '''' ]
]
