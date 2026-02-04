"Custom exception for expectation failures"
Class {
	#name : #ShExpectationFailed,
	#superclass : #Error,
	#instVars : [
		'expected',
		'actual',
		'matcher'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShExpectationFailed class >> expected: expectedValue actual: actualValue matcher: aMatcher [
	^ self new
		expected: expectedValue;
		actual: actualValue;
		matcher: aMatcher;
		yourself
]

{ #category : #accessing }
ShExpectationFailed >> expected [
	^ expected
]

{ #category : #accessing }
ShExpectationFailed >> expected: aValue [
	expected := aValue
]

{ #category : #accessing }
ShExpectationFailed >> actual [
	^ actual
]

{ #category : #accessing }
ShExpectationFailed >> actual: aValue [
	actual := aValue
]

{ #category : #accessing }
ShExpectationFailed >> matcher [
	^ matcher
]

{ #category : #accessing }
ShExpectationFailed >> matcher: aMatcher [
	matcher := aMatcher
]

{ #category : #accessing }
ShExpectationFailed >> description [
	^ 'ExpectationFailed'
]

{ #category : #accessing }
ShExpectationFailed >> messageText [
	matcher isNil ifTrue: [ ^ super messageText ].
	^ matcher failureMessage
]
