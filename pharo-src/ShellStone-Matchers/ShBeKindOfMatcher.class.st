"BeKindOf matcher - type checking"
Class {
	#name : #ShBeKindOfMatcher,
	#superclass : #ShBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShBeKindOfMatcher class >> expected: aClass [
	^ self new expected: aClass; yourself
]

{ #category : #matching }
ShBeKindOfMatcher >> matches: actualValue [
	^ actualValue isKindOf: expected
]

{ #category : #messages }
ShBeKindOfMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to be a kind of ', expected name, ' but was ', actual class name
]

{ #category : #messages }
ShBeKindOfMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to be a kind of ', expected name
]

{ #category : #messages }
ShBeKindOfMatcher >> description [
	^ 'be a kind of ', expected name
]
