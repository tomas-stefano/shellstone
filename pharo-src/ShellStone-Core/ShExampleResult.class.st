"Result tracking for examples (passed/failed/pending)"
Class {
	#name : #ShExampleResult,
	#superclass : #Object,
	#instVars : [
		'example',
		'status',
		'exception',
		'startTime',
		'endTime'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShExampleResult class >> passed: anExample [
	^ self new
		example: anExample;
		status: #passed;
		yourself
]

{ #category : #'instance creation' }
ShExampleResult class >> failed: anExample exception: anException [
	^ self new
		example: anExample;
		status: #failed;
		exception: anException;
		yourself
]

{ #category : #'instance creation' }
ShExampleResult class >> pending: anExample [
	^ self new
		example: anExample;
		status: #pending;
		yourself
]

{ #category : #'instance creation' }
ShExampleResult class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShExampleResult >> initialize [
	status := #pending
]

{ #category : #accessing }
ShExampleResult >> example [
	^ example
]

{ #category : #accessing }
ShExampleResult >> example: anExample [
	example := anExample
]

{ #category : #accessing }
ShExampleResult >> status [
	^ status
]

{ #category : #accessing }
ShExampleResult >> status: aSymbol [
	status := aSymbol
]

{ #category : #accessing }
ShExampleResult >> exception [
	^ exception
]

{ #category : #accessing }
ShExampleResult >> exception: anException [
	exception := anException
]

{ #category : #accessing }
ShExampleResult >> startTime [
	^ startTime
]

{ #category : #accessing }
ShExampleResult >> startTime: aTime [
	startTime := aTime
]

{ #category : #accessing }
ShExampleResult >> endTime [
	^ endTime
]

{ #category : #accessing }
ShExampleResult >> endTime: aTime [
	endTime := aTime
]

{ #category : #testing }
ShExampleResult >> passed [
	^ status = #passed
]

{ #category : #testing }
ShExampleResult >> failed [
	^ status = #failed
]

{ #category : #testing }
ShExampleResult >> pending [
	^ status = #pending
]

{ #category : #accessing }
ShExampleResult >> duration [
	(startTime isNil or: [ endTime isNil ]) ifTrue: [ ^ 0 ].
	^ endTime - startTime
]

{ #category : #accessing }
ShExampleResult >> failureMessage [
	exception isNil ifTrue: [ ^ '' ].
	^ exception messageText
]

{ #category : #accessing }
ShExampleResult >> fullDescription [
	^ example fullDescription
]

{ #category : #accessing }
ShExampleResult >> location [
	^ example location
]
