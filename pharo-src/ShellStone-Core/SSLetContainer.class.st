"Container for let definitions within an example context"
Class {
	#name : #SSLetContainer,
	#superclass : #Object,
	#instVars : [
		'definitions'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSLetContainer class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSLetContainer >> initialize [
	definitions := Dictionary new
]

{ #category : #accessing }
SSLetContainer >> definitions [
	^ definitions
]

{ #category : #defining }
SSLetContainer >> define: aSymbol as: aBlock [
	definitions at: aSymbol put: (SSLetDefinition name: aSymbol block: aBlock)
]

{ #category : #accessing }
SSLetContainer >> get: aSymbol [
	^ (definitions at: aSymbol ifAbsent: [
		self error: 'No let definition for: ', aSymbol printString
	]) value
]

{ #category : #testing }
SSLetContainer >> has: aSymbol [
	^ definitions includesKey: aSymbol
]

{ #category : #resetting }
SSLetContainer >> reset [
	"Reset all definitions for next example"
	definitions do: [ :def | def reset ]
]

{ #category : #merging }
SSLetContainer >> merge: aLetContainer [
	"Merge definitions from parent"
	aLetContainer definitions keysAndValuesDo: [ :k :v |
		(definitions includesKey: k) ifFalse: [
			definitions at: k put: (SSLetDefinition name: k block: v block)
		]
	]
]
