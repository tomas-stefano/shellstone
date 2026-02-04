"Custom exception for expectation failures"
Class {
	#name : #SSExpectationFailed,
	#superclass : #Error,
	#instVars : [
		'expected',
		'actual',
		'matcher'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSExpectationFailed class >> expected: expectedValue actual: actualValue matcher: aMatcher [
	^ self new
		expected: expectedValue;
		actual: actualValue;
		matcher: aMatcher;
		yourself
]

{ #category : #accessing }
SSExpectationFailed >> expected [
	^ expected
]

{ #category : #accessing }
SSExpectationFailed >> expected: aValue [
	expected := aValue
]

{ #category : #accessing }
SSExpectationFailed >> actual [
	^ actual
]

{ #category : #accessing }
SSExpectationFailed >> actual: aValue [
	actual := aValue
]

{ #category : #accessing }
SSExpectationFailed >> matcher [
	^ matcher
]

{ #category : #accessing }
SSExpectationFailed >> matcher: aMatcher [
	matcher := aMatcher
]

{ #category : #accessing }
SSExpectationFailed >> description [
	^ 'ExpectationFailed'
]

{ #category : #accessing }
SSExpectationFailed >> messageText [
	matcher isNil ifTrue: [ ^ super messageText ].
	^ matcher failureMessage
]
