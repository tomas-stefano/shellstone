"ShellStone DSL entry point"
Class {
	#name : #SS,
	#superclass : #Object,
	#category : #'ShellStone-Core'
}

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
