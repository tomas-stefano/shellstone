"Match matcher - regex pattern matching"
Class {
	#name : #ShMatchMatcher,
	#superclass : #ShBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShMatchMatcher class >> expected: aPattern [
	^ self new expected: aPattern; yourself
]

{ #category : #matching }
ShMatchMatcher >> matches: actualValue [
	"Use simple substring matching for now"
	^ actualValue asString includesSubstring: expected asString
]

{ #category : #messages }
ShMatchMatcher >> positiveFailureMessage [
	^ 'expected ''', actual asString, ''' to match ''', expected asString, ''''
]

{ #category : #messages }
ShMatchMatcher >> negativeFailureMessage [
	^ 'expected ''', actual asString, ''' not to match ''', expected asString, ''''
]

{ #category : #messages }
ShMatchMatcher >> description [
	^ 'match ''', expected asString, ''''
]
