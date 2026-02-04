"Memoized helper definitions (let)"
Class {
	#name : #ShLetDefinition,
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
ShLetDefinition class >> name: aSymbol block: aBlock [
	^ self new
		name: aSymbol;
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
ShLetDefinition class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShLetDefinition >> initialize [
	evaluated := false
]

{ #category : #accessing }
ShLetDefinition >> name [
	^ name
]

{ #category : #accessing }
ShLetDefinition >> name: aSymbol [
	name := aSymbol
]

{ #category : #accessing }
ShLetDefinition >> block [
	^ block
]

{ #category : #accessing }
ShLetDefinition >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
ShLetDefinition >> value [
	"Memoize the value - only evaluate once per example"
	evaluated ifFalse: [
		value := block value.
		evaluated := true
	].
	^ value
]

{ #category : #resetting }
ShLetDefinition >> reset [
	"Reset for next example"
	evaluated := false.
	value := nil
]

{ #category : #testing }
ShLetDefinition >> evaluated [
	^ evaluated
]
