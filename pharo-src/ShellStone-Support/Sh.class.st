"ShellStone DSL entry point"
Class {
	#name : #Sh,
	#superclass : #Object,
	#category : #'ShellStone-Support'
}

{ #category : #describing }
Sh class >> describe: aSubject do: aBlock [
	^ ShDescribe the: aSubject do: aBlock
]

{ #category : #describing }
Sh class >> describe: aSubject tag: aTag do: aBlock [
	^ ShDescribe the: aSubject tag: aTag do: aBlock
]

{ #category : #describing }
Sh class >> describe: aSubject tags: aTags do: aBlock [
	^ ShDescribe the: aSubject tags: aTags do: aBlock
]

{ #category : #expectations }
Sh class >> expect: aValue [
	"RSpec-style expect syntax"
	^ ShExpectationTarget for: aValue
]

{ #category : #mocks }
Sh class >> double [
	^ ShDouble new
]

{ #category : #mocks }
Sh class >> double: aName [
	^ ShDouble named: aName
]

{ #category : #mocks }
Sh class >> spyOn: anObject [
	^ ShSpy on: anObject
]
