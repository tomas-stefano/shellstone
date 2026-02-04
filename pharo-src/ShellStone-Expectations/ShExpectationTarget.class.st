"Wrapper for actual values in expectations"
Class {
	#name : #ShExpectationTarget,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
ShExpectationTarget class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
ShExpectationTarget >> actual [
	^ actual
]

{ #category : #accessing }
ShExpectationTarget >> actual: aValue [
	actual := aValue
]

{ #category : #expectations }
ShExpectationTarget >> should [
	"Main entry point for positive expectations"
	^ ShPositiveHandler for: actual
]

{ #category : #expectations }
ShExpectationTarget >> shouldNot [
	"Main entry point for negative expectations"
	^ ShNegativeHandler for: actual
]

{ #category : #expectations }
ShExpectationTarget >> to [
	"RSpec 3 style alias"
	^ self should
]

{ #category : #expectations }
ShExpectationTarget >> toNot [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
ShExpectationTarget >> to_not [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
ShExpectationTarget >> notTo [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
ShExpectationTarget >> not_to [
	"RSpec 3 style alias"
	^ self shouldNot
]
