"Equal matcher - checks if actual equals expected"
Class {
	#name : #SSEqualMatcher,
	#superclass : #SSBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSEqualMatcher class >> expected: aValue [
	^ self new expected: aValue; yourself
]

{ #category : #matching }
SSEqualMatcher >> matches: actualValue [
	^ actualValue = expected
]

{ #category : #messages }
SSEqualMatcher >> positiveFailureMessage [
	^ 'expected ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
SSEqualMatcher >> negativeFailureMessage [
	^ 'expected value to not equal ', expected printString
]

{ #category : #messages }
SSEqualMatcher >> description [
	^ 'equal ', expected printString
]
