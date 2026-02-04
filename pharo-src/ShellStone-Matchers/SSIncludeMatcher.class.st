"Include matcher - check if collection includes item(s)"
Class {
	#name : #SSIncludeMatcher,
	#superclass : #SSBaseMatcher,
	#instVars : [
		'multipleExpected'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSIncludeMatcher class >> expected: aValue [
	^ self new expected: aValue; yourself
]

{ #category : #'instance creation' }
SSIncludeMatcher class >> expectedAll: aCollection [
	^ self new
		expected: aCollection;
		multipleExpected: true;
		yourself
]

{ #category : #accessing }
SSIncludeMatcher >> multipleExpected [
	^ multipleExpected ifNil: [ false ]
]

{ #category : #accessing }
SSIncludeMatcher >> multipleExpected: aBoolean [
	multipleExpected := aBoolean
]

{ #category : #matching }
SSIncludeMatcher >> matches: actualValue [
	self multipleExpected ifTrue: [
		^ expected allSatisfy: [ :item | self doesActual: actualValue include: item ]
	].
	^ self doesActual: actualValue include: expected
]

{ #category : #private }
SSIncludeMatcher >> doesActual: actualValue include: item [
	"Handle string substring matching differently"
	(actualValue isKindOf: String) ifTrue: [
		(item isKindOf: String) ifTrue: [
			^ actualValue includesSubstring: item
		]
	].
	^ actualValue includes: item
]

{ #category : #messages }
SSIncludeMatcher >> positiveFailureMessage [
	self multipleExpected ifTrue: [
		| missing |
		missing := expected reject: [ :item | actual includes: item ].
		^ 'expected ', actual printString, ' to include ', missing printString
	].
	^ 'expected ', actual printString, ' to include ', expected printString
]

{ #category : #messages }
SSIncludeMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to include ', expected printString
]

{ #category : #messages }
SSIncludeMatcher >> description [
	^ 'include ', expected printString
]
