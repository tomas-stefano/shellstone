"Entry point DSL for defining test suites"
Class {
	#name : #SSDescribe,
	#superclass : #Object,
	#category : #'ShellStone-Core'
}

{ #category : #'dsl - main' }
SSDescribe class >> the: aSubject do: aBlock [
	"Main entry point for describe blocks"
	| group description |
	description := aSubject isString
		ifTrue: [ aSubject ]
		ifFalse: [ aSubject name ].
	group := SSExampleGroup description: description.
	SSWorld instance register: group.
	aBlock value: group.
	^ group
]

{ #category : #'dsl - tags' }
SSDescribe class >> the: aSubject tag: aTag do: aBlock [
	| group |
	group := self the: aSubject do: aBlock.
	group addTag: aTag.
	^ group
]

{ #category : #'dsl - tags' }
SSDescribe class >> the: aSubject tags: aTags do: aBlock [
	| group |
	group := self the: aSubject do: aBlock.
	group addTags: aTags.
	^ group
]

{ #category : #'dsl - alias' }
SSDescribe class >> describe: aSubject do: aBlock [
	"Convenience alias"
	^ self the: aSubject do: aBlock
]
