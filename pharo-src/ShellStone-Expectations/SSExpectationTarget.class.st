"Wrapper for actual values in expectations"
Class {
	#name : #SSExpectationTarget,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
SSExpectationTarget class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
SSExpectationTarget >> actual [
	^ actual
]

{ #category : #accessing }
SSExpectationTarget >> actual: aValue [
	actual := aValue
]

{ #category : #expectations }
SSExpectationTarget >> should [
	"Main entry point for positive expectations"
	^ SSPositiveHandler for: actual
]

{ #category : #expectations }
SSExpectationTarget >> shouldNot [
	"Main entry point for negative expectations"
	^ SSNegativeHandler for: actual
]

{ #category : #expectations }
SSExpectationTarget >> to [
	"RSpec 3 style alias"
	^ self should
]

{ #category : #expectations }
SSExpectationTarget >> toNot [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
SSExpectationTarget >> to_not [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
SSExpectationTarget >> notTo [
	"RSpec 3 style alias"
	^ self shouldNot
]

{ #category : #expectations }
SSExpectationTarget >> not_to [
	"RSpec 3 style alias"
	^ self shouldNot
]
