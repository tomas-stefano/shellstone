"RespondTo matcher - check if object responds to a method"
Class {
	#name : #SSRespondToMatcher,
	#superclass : #SSBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSRespondToMatcher class >> expected: aSelector [
	^ self new expected: aSelector; yourself
]

{ #category : #matching }
SSRespondToMatcher >> matches: actualValue [
	^ actualValue respondsTo: expected
]

{ #category : #messages }
SSRespondToMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to respond to #', expected asString
]

{ #category : #messages }
SSRespondToMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to respond to #', expected asString
]

{ #category : #messages }
SSRespondToMatcher >> description [
	^ 'respond to #', expected asString
]
