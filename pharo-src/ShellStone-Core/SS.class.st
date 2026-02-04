"ShellStone DSL entry point"
Class {
	#name : #SS,
	#superclass : #Object,
	#category : #'ShellStone-Core'
}

{ #category : #describing }
SS class >> describe: aSubject do: aBlock [
	^ SSDescribe the: aSubject do: aBlock
]

{ #category : #describing }
SS class >> describe: aSubject tag: aTag do: aBlock [
	^ SSDescribe the: aSubject tag: aTag do: aBlock
]

{ #category : #describing }
SS class >> describe: aSubject tags: aTags do: aBlock [
	^ SSDescribe the: aSubject tags: aTags do: aBlock
]

{ #category : #expectations }
SS class >> expect: aValue [
	"RSpec-style expect syntax"
	^ SSExpectationTarget for: aValue
]

{ #category : #mocks }
SS class >> double [
	^ SSDouble new
]

{ #category : #mocks }
SS class >> double: aName [
	^ SSDouble named: aName
]

{ #category : #mocks }
SS class >> spyOn: anObject [
	^ SSSpy on: anObject
]
