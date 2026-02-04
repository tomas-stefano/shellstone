"Be matcher - truthy/falsy/nil checks"
Class {
	#name : #ShBeMatcher,
	#superclass : #ShBaseMatcher,
	#instVars : [
		'mode'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShBeMatcher class >> expected: aValue [
	^ self new mode: #value; expected: aValue; yourself
]

{ #category : #'instance creation' }
ShBeMatcher class >> forTruthy [
	^ self new mode: #truthy; yourself
]

{ #category : #'instance creation' }
ShBeMatcher class >> forFalsy [
	^ self new mode: #falsy; yourself
]

{ #category : #'instance creation' }
ShBeMatcher class >> forNil [
	^ self new mode: #nil; yourself
]

{ #category : #accessing }
ShBeMatcher >> mode [
	^ mode
]

{ #category : #accessing }
ShBeMatcher >> mode: aSymbol [
	mode := aSymbol
]

{ #category : #matching }
ShBeMatcher >> matches: actualValue [
	mode = #truthy ifTrue: [
		^ actualValue notNil and: [ actualValue ~= false ]
	].
	mode = #falsy ifTrue: [
		^ actualValue isNil or: [ actualValue = false ]
	].
	mode = #nil ifTrue: [
		^ actualValue isNil
	].
	"Mode is #value - compare identity"
	^ actualValue == expected
]

{ #category : #messages }
ShBeMatcher >> positiveFailureMessage [
	mode = #truthy ifTrue: [
		^ 'expected ', actual printString, ' to be truthy'
	].
	mode = #falsy ifTrue: [
		^ 'expected ', actual printString, ' to be falsy'
	].
	mode = #nil ifTrue: [
		^ 'expected ', actual printString, ' to be nil'
	].
	^ 'expected ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
ShBeMatcher >> negativeFailureMessage [
	mode = #truthy ifTrue: [
		^ 'expected ', actual printString, ' not to be truthy'
	].
	mode = #falsy ifTrue: [
		^ 'expected ', actual printString, ' not to be falsy'
	].
	mode = #nil ifTrue: [
		^ 'expected ', actual printString, ' not to be nil'
	].
	^ 'expected value not to be ', expected printString
]

{ #category : #messages }
ShBeMatcher >> description [
	mode = #truthy ifTrue: [ ^ 'be truthy' ].
	mode = #falsy ifTrue: [ ^ 'be falsy' ].
	mode = #nil ifTrue: [ ^ 'be nil' ].
	^ 'be ', expected printString
]
