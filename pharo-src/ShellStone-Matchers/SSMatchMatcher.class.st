"Match matcher - regex pattern matching"
Class {
	#name : #SSMatchMatcher,
	#superclass : #SSBaseMatcher,
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSMatchMatcher class >> expected: aPattern [
	^ self new expected: aPattern; yourself
]

{ #category : #matching }
SSMatchMatcher >> matches: actualValue [
	"Use simple substring matching for now"
	^ actualValue asString includesSubstring: expected asString
]

{ #category : #messages }
SSMatchMatcher >> positiveFailureMessage [
	^ 'expected ''', actual asString, ''' to match ''', expected asString, ''''
]

{ #category : #messages }
SSMatchMatcher >> negativeFailureMessage [
	^ 'expected ''', actual asString, ''' not to match ''', expected asString, ''''
]

{ #category : #messages }
SSMatchMatcher >> description [
	^ 'match ''', expected asString, ''''
]
