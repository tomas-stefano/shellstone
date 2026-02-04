"BeKindOf matcher - type checking"
Class {
	#name : #SSBeKindOfMatcher,
	#superclass : #SSBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSBeKindOfMatcher class >> expected: aClass [
	^ self new expected: aClass; yourself
]

{ #category : #matching }
SSBeKindOfMatcher >> matches: actualValue [
	^ actualValue isKindOf: expected
]

{ #category : #messages }
SSBeKindOfMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to be a kind of ', expected name, ' but was ', actual class name
]

{ #category : #messages }
SSBeKindOfMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to be a kind of ', expected name
]

{ #category : #messages }
SSBeKindOfMatcher >> description [
	^ 'be a kind of ', expected name
]
