"Method stub for doubles"
Class {
	#name : #SSMethodStub,
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
SSMethodStub class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSMethodStub >> initialize [
	callCount := 0
]

{ #category : #accessing }
SSMethodStub >> double [
	^ double
]

{ #category : #accessing }
SSMethodStub >> double: aDouble [
	double := aDouble
]

{ #category : #accessing }
SSMethodStub >> selector [
	^ selector
]

{ #category : #accessing }
SSMethodStub >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
SSMethodStub >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SSMethodStub >> returnValue: aValue [
	returnValue := aValue
]

{ #category : #accessing }
SSMethodStub >> block [
	^ block
]

{ #category : #accessing }
SSMethodStub >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
SSMethodStub >> exception [
	^ exception
]

{ #category : #accessing }
SSMethodStub >> exception: anException [
	exception := anException
]

{ #category : #accessing }
SSMethodStub >> callCount [
	^ callCount
]

{ #category : #chaining }
SSMethodStub >> andReturn: aValue [
	returnValue := aValue.
	^ self
]

{ #category : #chaining }
SSMethodStub >> andDo: aBlock [
	block := aBlock.
	^ self
]

{ #category : #chaining }
SSMethodStub >> andRaise: anException [
	exception := anException.
	^ self
]

{ #category : #executing }
SSMethodStub >> valueWithArgs: anArray [
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
SSMethodStub >> value [
	^ self valueWithArgs: #()
]
