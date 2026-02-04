"Comparison matchers - >, <, >=, <="
Class {
	#name : #ShComparisonMatcher,
	#superclass : #ShBaseMatcher,
	#instVars : [
		'operator'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
ShComparisonMatcher class >> operator: aSymbol expected: aValue [
	^ self new
		operator: aSymbol;
		expected: aValue;
		yourself
]

{ #category : #accessing }
ShComparisonMatcher >> operator [
	^ operator
]

{ #category : #accessing }
ShComparisonMatcher >> operator: aSymbol [
	operator := aSymbol
]

{ #category : #matching }
ShComparisonMatcher >> matches: actualValue [
	operator = #> ifTrue: [ ^ actualValue > expected ].
	operator = #< ifTrue: [ ^ actualValue < expected ].
	operator = #>= ifTrue: [ ^ actualValue >= expected ].
	operator = #<= ifTrue: [ ^ actualValue <= expected ].
	^ false
]

{ #category : #private }
ShComparisonMatcher >> operatorDescription [
	operator = #> ifTrue: [ ^ 'greater than' ].
	operator = #< ifTrue: [ ^ 'less than' ].
	operator = #>= ifTrue: [ ^ 'greater than or equal to' ].
	operator = #<= ifTrue: [ ^ 'less than or equal to' ].
	^ 'compare to'
]

{ #category : #messages }
ShComparisonMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to be ', self operatorDescription, ' ', expected printString
]

{ #category : #messages }
ShComparisonMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to be ', self operatorDescription, ' ', expected printString
]

{ #category : #messages }
ShComparisonMatcher >> description [
	^ 'be ', self operatorDescription, ' ', expected printString
]
