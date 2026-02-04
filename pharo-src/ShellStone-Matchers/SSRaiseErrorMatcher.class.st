"RaiseError matcher - exception testing"
Class {
	#name : #SSRaiseErrorMatcher,
	#superclass : #SSBaseMatcher,
	#instVars : [
		'raisedException',
		'expectedMessage'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSRaiseErrorMatcher class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
SSRaiseErrorMatcher class >> expected: anExceptionClass [
	^ self new expected: anExceptionClass; yourself
]

{ #category : #'instance creation' }
SSRaiseErrorMatcher class >> expected: anExceptionClass message: aString [
	^ self new
		expected: anExceptionClass;
		expectedMessage: aString;
		yourself
]

{ #category : #initialization }
SSRaiseErrorMatcher >> initialize [
	super initialize.
	expected := Exception.
	raisedException := nil
]

{ #category : #accessing }
SSRaiseErrorMatcher >> expectedMessage [
	^ expectedMessage
]

{ #category : #accessing }
SSRaiseErrorMatcher >> expectedMessage: aString [
	expectedMessage := aString
]

{ #category : #accessing }
SSRaiseErrorMatcher >> raisedException [
	^ raisedException
]

{ #category : #matching }
SSRaiseErrorMatcher >> matches: actualValue [
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
SSRaiseErrorMatcher >> positiveFailureMessage [
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
SSRaiseErrorMatcher >> negativeFailureMessage [
	^ 'expected block not to raise ', expected name, ' but it did'
]

{ #category : #messages }
SSRaiseErrorMatcher >> description [
	expectedMessage isNil
		ifTrue: [ ^ 'raise ', expected name ]
		ifFalse: [ ^ 'raise ', expected name, ' with message ''', expectedMessage, '''' ]
]
