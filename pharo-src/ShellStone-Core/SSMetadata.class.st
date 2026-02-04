"Metadata/tagging support for examples and groups"
Class {
	#name : #SSMetadata,
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
SSMetadata class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSMetadata >> initialize [
	tags := Set new.
	data := Dictionary new
]

{ #category : #accessing }
SSMetadata >> tags [
	^ tags
]

{ #category : #accessing }
SSMetadata >> data [
	^ data
]

{ #category : #accessing }
SSMetadata >> location [
	^ location
]

{ #category : #accessing }
SSMetadata >> location: aString [
	location := aString
]

{ #category : #accessing }
SSMetadata >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
SSMetadata >> lineNumber: anInteger [
	lineNumber := anInteger
]

{ #category : #accessing }
SSMetadata >> fileName [
	^ fileName
]

{ #category : #accessing }
SSMetadata >> fileName: aString [
	fileName := aString
]

{ #category : #tags }
SSMetadata >> addTag: aSymbol [
	tags add: aSymbol
]

{ #category : #tags }
SSMetadata >> addTags: aCollection [
	aCollection do: [ :tag | self addTag: tag ]
]

{ #category : #tags }
SSMetadata >> hasTag: aSymbol [
	^ tags includes: aSymbol
]

{ #category : #tags }
SSMetadata >> hasAnyTag: aCollection [
	^ aCollection anySatisfy: [ :tag | self hasTag: tag ]
]

{ #category : #data }
SSMetadata >> at: aKey [
	^ data at: aKey ifAbsent: [ nil ]
]

{ #category : #data }
SSMetadata >> at: aKey put: aValue [
	data at: aKey put: aValue
]

{ #category : #merging }
SSMetadata >> merge: aMetadata [
	aMetadata tags do: [ :tag | self addTag: tag ].
	aMetadata data keysAndValuesDo: [ :k :v | self at: k put: v ]
]

{ #category : #accessing }
SSMetadata >> fullLocation [
	fileName isNil ifTrue: [ ^ '' ].
	lineNumber isNil ifTrue: [ ^ fileName ].
	^ fileName, ':', lineNumber printString
]
