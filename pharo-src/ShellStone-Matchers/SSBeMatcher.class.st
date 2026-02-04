"Be matcher - truthy/falsy/nil checks"
Class {
	#name : #SSBeMatcher,
	#superclass : #SSBaseMatcher,
	#instVars : [
		'mode'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSBeMatcher class >> expected: aValue [
	^ self new mode: #value; expected: aValue; yourself
]

{ #category : #'instance creation' }
SSBeMatcher class >> forTruthy [
	^ self new mode: #truthy; yourself
]

{ #category : #'instance creation' }
SSBeMatcher class >> forFalsy [
	^ self new mode: #falsy; yourself
]

{ #category : #'instance creation' }
SSBeMatcher class >> forNil [
	^ self new mode: #nil; yourself
]

{ #category : #accessing }
SSBeMatcher >> mode [
	^ mode
]

{ #category : #accessing }
SSBeMatcher >> mode: aSymbol [
	mode := aSymbol
]

{ #category : #matching }
SSBeMatcher >> matches: actualValue [
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
SSBeMatcher >> positiveFailureMessage [
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
SSBeMatcher >> negativeFailureMessage [
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
SSBeMatcher >> description [
	mode = #truthy ifTrue: [ ^ 'be truthy' ].
	mode = #falsy ifTrue: [ ^ 'be falsy' ].
	mode = #nil ifTrue: [ ^ 'be nil' ].
	^ 'be ', expected printString
]
