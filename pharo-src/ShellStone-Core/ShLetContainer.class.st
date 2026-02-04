"Container for let definitions within an example context"
Class {
	#name : #ShLetContainer,
	#superclass : #Object,
	#instVars : [
		'definitions'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShLetContainer class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShLetContainer >> initialize [
	definitions := Dictionary new
]

{ #category : #accessing }
ShLetContainer >> definitions [
	^ definitions
]

{ #category : #defining }
ShLetContainer >> define: aSymbol as: aBlock [
	definitions at: aSymbol put: (ShLetDefinition name: aSymbol block: aBlock)
]

{ #category : #accessing }
ShLetContainer >> get: aSymbol [
	^ (definitions at: aSymbol ifAbsent: [
		self error: 'No let definition for: ', aSymbol printString
	]) value
]

{ #category : #testing }
ShLetContainer >> has: aSymbol [
	^ definitions includesKey: aSymbol
]

{ #category : #resetting }
ShLetContainer >> reset [
	"Reset all definitions for next example"
	definitions do: [ :def | def reset ]
]

{ #category : #merging }
ShLetContainer >> merge: aLetContainer [
	"Merge definitions from parent"
	aLetContainer definitions keysAndValuesDo: [ :k :v |
		(definitions includesKey: k) ifFalse: [
			definitions at: k put: (ShLetDefinition name: k block: v block)
		]
	]
]
