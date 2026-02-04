"Abstract base class for all matchers"
Class {
	#name : #ShBaseMatcher,
	#superclass : #Object,
	#instVars : [
		'actual',
		'expected',
		'negated'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShBaseMatcher class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShBaseMatcher >> initialize [
	negated := false
]

{ #category : #accessing }
ShBaseMatcher >> actual [
	^ actual
]

{ #category : #accessing }
ShBaseMatcher >> actual: aValue [
	actual := aValue
]

{ #category : #accessing }
ShBaseMatcher >> expected [
	^ expected
]

{ #category : #accessing }
ShBaseMatcher >> expected: aValue [
	expected := aValue
]

{ #category : #accessing }
ShBaseMatcher >> negated [
	^ negated
]

{ #category : #accessing }
ShBaseMatcher >> negated: aBoolean [
	negated := aBoolean
]

{ #category : #matching }
ShBaseMatcher >> matches: actualValue [
	"Override in subclasses to perform the match"
	self subclassResponsibility
]

{ #category : #matching }
ShBaseMatcher >> matchesWithNegation: actualValue [
	"Returns true if match passes (considering negation)"
	| result |
	actual := actualValue.
	result := self matches: actualValue.
	negated ifTrue: [ ^ result not ].
	^ result
]

{ #category : #messages }
ShBaseMatcher >> failureMessage [
	negated
		ifTrue: [ ^ self negativeFailureMessage ]
		ifFalse: [ ^ self positiveFailureMessage ]
]

{ #category : #messages }
ShBaseMatcher >> positiveFailureMessage [
	^ 'expected ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
ShBaseMatcher >> negativeFailureMessage [
	^ 'expected not ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
ShBaseMatcher >> description [
	"Human-readable description of what the matcher expects"
	^ 'match'
]

{ #category : #matching }
ShBaseMatcher >> negate [
	"Chainable method for negation"
	negated := true.
	^ self
]
