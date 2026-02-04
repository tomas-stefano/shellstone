"Comparison matchers - >, <, >=, <="
Class {
	#name : #SSComparisonMatcher,
	#superclass : #SSBaseMatcher,
	#instVars : [
		'operator'
	],
	#category : #'ShellStone-Matchers'
}

{ #category : #'instance creation' }
SSComparisonMatcher class >> operator: aSymbol expected: aValue [
	^ self new
		operator: aSymbol;
		expected: aValue;
		yourself
]

{ #category : #accessing }
SSComparisonMatcher >> operator [
	^ operator
]

{ #category : #accessing }
SSComparisonMatcher >> operator: aSymbol [
	operator := aSymbol
]

{ #category : #matching }
SSComparisonMatcher >> matches: actualValue [
	operator = #> ifTrue: [ ^ actualValue > expected ].
	operator = #< ifTrue: [ ^ actualValue < expected ].
	operator = #>= ifTrue: [ ^ actualValue >= expected ].
	operator = #<= ifTrue: [ ^ actualValue <= expected ].
	^ false
]

{ #category : #private }
SSComparisonMatcher >> operatorDescription [
	operator = #> ifTrue: [ ^ 'greater than' ].
	operator = #< ifTrue: [ ^ 'less than' ].
	operator = #>= ifTrue: [ ^ 'greater than or equal to' ].
	operator = #<= ifTrue: [ ^ 'less than or equal to' ].
	^ 'compare to'
]

{ #category : #messages }
SSComparisonMatcher >> positiveFailureMessage [
	^ 'expected ', actual printString, ' to be ', self operatorDescription, ' ', expected printString
]

{ #category : #messages }
SSComparisonMatcher >> negativeFailureMessage [
	^ 'expected ', actual printString, ' not to be ', self operatorDescription, ' ', expected printString
]

{ #category : #messages }
SSComparisonMatcher >> description [
	^ 'be ', self operatorDescription, ' ', expected printString
]
