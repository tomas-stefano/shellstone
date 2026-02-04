"Metadata/tagging support for examples and groups"
Class {
	#name : #ShMetadata,
	#superclass : #Object,
	#instVars : [
		'tags',
		'data',
		'location',
		'lineNumber',
		'fileName'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShMetadata class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShMetadata >> initialize [
	tags := Set new.
	data := Dictionary new
]

{ #category : #accessing }
ShMetadata >> tags [
	^ tags
]

{ #category : #accessing }
ShMetadata >> data [
	^ data
]

{ #category : #accessing }
ShMetadata >> location [
	^ location
]

{ #category : #accessing }
ShMetadata >> location: aString [
	location := aString
]

{ #category : #accessing }
ShMetadata >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
ShMetadata >> lineNumber: anInteger [
	lineNumber := anInteger
]

{ #category : #accessing }
ShMetadata >> fileName [
	^ fileName
]

{ #category : #accessing }
ShMetadata >> fileName: aString [
	fileName := aString
]

{ #category : #tags }
ShMetadata >> addTag: aSymbol [
	tags add: aSymbol
]

{ #category : #tags }
ShMetadata >> addTags: aCollection [
	aCollection do: [ :tag | self addTag: tag ]
]

{ #category : #tags }
ShMetadata >> hasTag: aSymbol [
	^ tags includes: aSymbol
]

{ #category : #tags }
ShMetadata >> hasAnyTag: aCollection [
	^ aCollection anySatisfy: [ :tag | self hasTag: tag ]
]

{ #category : #data }
ShMetadata >> at: aKey [
	^ data at: aKey ifAbsent: [ nil ]
]

{ #category : #data }
ShMetadata >> at: aKey put: aValue [
	data at: aKey put: aValue
]

{ #category : #merging }
ShMetadata >> merge: aMetadata [
	aMetadata tags do: [ :tag | self addTag: tag ].
	aMetadata data keysAndValuesDo: [ :k :v | self at: k put: v ]
]

{ #category : #accessing }
ShMetadata >> fullLocation [
	fileName isNil ifTrue: [ ^ '' ].
	lineNumber isNil ifTrue: [ ^ fileName ].
	^ fileName, ':', lineNumber printString
]
