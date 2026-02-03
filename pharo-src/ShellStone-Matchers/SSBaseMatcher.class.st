"Abstract base class for all matchers"
Class {
	#name : #SSBaseMatcher,
	#superclass : #Object,
	#instVars : [
		'actual',
		'expected',
		'negated'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSBaseMatcher class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSBaseMatcher >> initialize [
	negated := false
]

{ #category : #accessing }
SSBaseMatcher >> actual [
	^ actual
]

{ #category : #accessing }
SSBaseMatcher >> actual: aValue [
	actual := aValue
]

{ #category : #accessing }
SSBaseMatcher >> expected [
	^ expected
]

{ #category : #accessing }
SSBaseMatcher >> expected: aValue [
	expected := aValue
]

{ #category : #accessing }
SSBaseMatcher >> negated [
	^ negated
]

{ #category : #accessing }
SSBaseMatcher >> negated: aBoolean [
	negated := aBoolean
]

{ #category : #matching }
SSBaseMatcher >> matches: actualValue [
	"Override in subclasses to perform the match"
	self subclassResponsibility
]

{ #category : #matching }
SSBaseMatcher >> matchesWithNegation: actualValue [
	"Returns true if match passes (considering negation)"
	| result |
	actual := actualValue.
	result := self matches: actualValue.
	negated ifTrue: [ ^ result not ].
	^ result
]

{ #category : #messages }
SSBaseMatcher >> failureMessage [
	negated
		ifTrue: [ ^ self negativeFailureMessage ]
		ifFalse: [ ^ self positiveFailureMessage ]
]

{ #category : #messages }
SSBaseMatcher >> positiveFailureMessage [
	^ 'expected ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
SSBaseMatcher >> negativeFailureMessage [
	^ 'expected not ', expected printString, ' but got ', actual printString
]

{ #category : #messages }
SSBaseMatcher >> description [
	"Human-readable description of what the matcher expects"
	^ 'match'
]

{ #category : #matching }
SSBaseMatcher >> negate [
	"Chainable method for negation"
	negated := true.
	^ self
]
