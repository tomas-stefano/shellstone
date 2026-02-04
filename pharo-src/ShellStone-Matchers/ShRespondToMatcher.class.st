"RespondTo matcher - check if object responds to a method"
Class {
	#name : #ShRespondToMatcher,
	#superclass : #ShBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShRespondToMatcher class >> expected: aSelector [
	^ self new expected: aSelector; yourself
]

{ #category : #matching }
ShRespondToMatcher >> matches: actualValue [
	^ actualValue respondsTo: expected
]

{ #category : #messages }
ShRespondToMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to respond to #', expected asString
]

{ #category : #messages }
ShRespondToMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to respond to #', expected asString
]

{ #category : #messages }
ShRespondToMatcher >> description [
	^ 'respond to #', expected asString
]
