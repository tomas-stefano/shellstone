"Memoized helper definitions (let)"
Class {
	#name : #SSLetDefinition,
	#superclass : #Object,
	#instVars : [
		'name',
		'block',
		'value',
		'evaluated'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSLetDefinition class >> name: aSymbol block: aBlock [
	^ self new
		name: aSymbol;
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
SSLetDefinition class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSLetDefinition >> initialize [
	evaluated := false
]

{ #category : #accessing }
SSLetDefinition >> name [
	^ name
]

{ #category : #accessing }
SSLetDefinition >> name: aSymbol [
	name := aSymbol
]

{ #category : #accessing }
SSLetDefinition >> block [
	^ block
]

{ #category : #accessing }
SSLetDefinition >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
SSLetDefinition >> value [
	"Memoize the value - only evaluate once per example"
	evaluated ifFalse: [
		value := block value.
		evaluated := true
	].
	^ value
]

{ #category : #resetting }
SSLetDefinition >> reset [
	"Reset for next example"
	evaluated := false.
	value := nil
]

{ #category : #testing }
SSLetDefinition >> evaluated [
	^ evaluated
]
