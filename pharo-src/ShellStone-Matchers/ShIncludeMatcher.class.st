"Include matcher - check if collection includes item(s)"
Class {
	#name : #ShIncludeMatcher,
	#superclass : #ShBaseMatcher,
	#instVars : [
		'multipleExpected'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShIncludeMatcher class >> expected: aValue [
	^ self new expected: aValue; yourself
]

{ #category : #'instance creation' }
ShIncludeMatcher class >> expectedAll: aCollection [
	^ self new
		expected: aCollection;
		multipleExpected: true;
		yourself
]

{ #category : #accessing }
ShIncludeMatcher >> multipleExpected [
	^ multipleExpected ifNil: [ false ]
]

{ #category : #accessing }
ShIncludeMatcher >> multipleExpected: aBoolean [
	multipleExpected := aBoolean
]

{ #category : #matching }
ShIncludeMatcher >> matches: actualValue [
	self multipleExpected ifTrue: [
		^ expected allSatisfy: [ :item | self doesActual: actualValue include: item ]
	].
	^ self doesActual: actualValue include: expected
]

{ #category : #private }
ShIncludeMatcher >> doesActual: actualValue include: item [
	"Handle string substring matching differently"
	(actualValue isKindOf: String) ifTrue: [
		(item isKindOf: String) ifTrue: [
			^ actualValue includesSubstring: item
		]
	].
	^ actualValue includes: item
]

{ #category : #messages }
ShIncludeMatcher >> positiveFailureMessage [
	self multipleExpected ifTrue: [
		| missing |
		missing := expected reject: [ :item | actual includes: item ].
		^ 'expected ', actual printString, ' to include ', missing printString
	].
	^ 'expected ', actual printString, ' to include ', expected printString
]

{ #category : #messages }
ShIncludeMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to include ', expected printString
]

{ #category : #messages }
ShIncludeMatcher >> description [
	^ 'include ', expected printString
]
