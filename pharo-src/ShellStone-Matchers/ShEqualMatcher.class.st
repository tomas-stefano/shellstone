"Equal matcher - checks if actual equals expected"
Class {
	#name : #ShEqualMatcher,
	#superclass : #ShBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShEqualMatcher class >> expected: aValue [
	^ self new expected: aValue; yourself
]

{ #category : #matching }
ShEqualMatcher >> matches: actualValue [
	^ actualValue = expected
]

{ #category : #messages }
ShEqualMatcher >> positiveFailureMessage [
	^ 'expected ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
ShEqualMatcher >> negativeFailureMessage [
	^ 'expected value to not equal ', expected printString
]

{ #category : #messages }
ShEqualMatcher >> description [
	^ 'equal ', expected printString
]
