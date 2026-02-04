"Method stub for doubles"
Class {
	#name : #ShMethodStub,
	#superclass : #Object,
	#instVars : [
		'double',
		'selector',
		'returnValue',
		'block',
		'exception',
		'callCount'
	],
	#category : #'ShellStone-Mocks'
}

{ #category : #'instance creation' }
ShMethodStub class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShMethodStub >> initialize [
	callCount := 0
]

{ #category : #accessing }
ShMethodStub >> double [
	^ double
]

{ #category : #accessing }
ShMethodStub >> double: aDouble [
	double := aDouble
]

{ #category : #accessing }
ShMethodStub >> selector [
	^ selector
]

{ #category : #accessing }
ShMethodStub >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
ShMethodStub >> returnValue [
	^ returnValue
]

{ #category : #accessing }
ShMethodStub >> returnValue: aValue [
	returnValue := aValue
]

{ #category : #accessing }
ShMethodStub >> block [
	^ block
]

{ #category : #accessing }
ShMethodStub >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
ShMethodStub >> exception [
	^ exception
]

{ #category : #accessing }
ShMethodStub >> exception: anException [
	exception := anException
]

{ #category : #accessing }
ShMethodStub >> callCount [
	^ callCount
]

{ #category : #chaining }
ShMethodStub >> andReturn: aValue [
	returnValue := aValue.
	^ self
]

{ #category : #chaining }
ShMethodStub >> andDo: aBlock [
	block := aBlock.
	^ self
]

{ #category : #chaining }
ShMethodStub >> andRaise: anException [
	exception := anException.
	^ self
]

{ #category : #executing }
ShMethodStub >> valueWithArgs: anArray [
	callCount := callCount + 1.

	exception notNil ifTrue: [
		exception signal
	].

	block notNil ifTrue: [
		^ block valueWithArguments: anArray
	].

	^ returnValue
]

{ #category : #executing }
ShMethodStub >> value [
	^ self valueWithArgs: #()
]
