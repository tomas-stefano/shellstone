"Result tracking for examples (passed/failed/pending)"
Class {
	#name : #SSExampleResult,
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
SSExampleResult class >> passed: anExample [
	^ self new
		example: anExample;
		status: #passed;
		yourself
]

{ #category : #'instance creation' }
SSExampleResult class >> failed: anExample exception: anException [
	^ self new
		example: anExample;
		status: #failed;
		exception: anException;
		yourself
]

{ #category : #'instance creation' }
SSExampleResult class >> pending: anExample [
	^ self new
		example: anExample;
		status: #pending;
		yourself
]

{ #category : #'instance creation' }
SSExampleResult class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSExampleResult >> initialize [
	status := #pending
]

{ #category : #accessing }
SSExampleResult >> example [
	^ example
]

{ #category : #accessing }
SSExampleResult >> example: anExample [
	example := anExample
]

{ #category : #accessing }
SSExampleResult >> status [
	^ status
]

{ #category : #accessing }
SSExampleResult >> status: aSymbol [
	status := aSymbol
]

{ #category : #accessing }
SSExampleResult >> exception [
	^ exception
]

{ #category : #accessing }
SSExampleResult >> exception: anException [
	exception := anException
]

{ #category : #accessing }
SSExampleResult >> startTime [
	^ startTime
]

{ #category : #accessing }
SSExampleResult >> startTime: aTime [
	startTime := aTime
]

{ #category : #accessing }
SSExampleResult >> endTime [
	^ endTime
]

{ #category : #accessing }
SSExampleResult >> endTime: aTime [
	endTime := aTime
]

{ #category : #testing }
SSExampleResult >> passed [
	^ status = #passed
]

{ #category : #testing }
SSExampleResult >> failed [
	^ status = #failed
]

{ #category : #testing }
SSExampleResult >> pending [
	^ status = #pending
]

{ #category : #accessing }
SSExampleResult >> duration [
	(startTime isNil or: [ endTime isNil ]) ifTrue: [ ^ 0 ].
	^ endTime - startTime
]

{ #category : #accessing }
SSExampleResult >> failureMessage [
	exception isNil ifTrue: [ ^ '' ].
	^ exception messageText
]

{ #category : #accessing }
SSExampleResult >> fullDescription [
	^ example fullDescription
]

{ #category : #accessing }
SSExampleResult >> location [
	^ example location
]
