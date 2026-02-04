"Example group registry (World)"
Class {
	#name : #ShWorld,
	#superclass : #Object,
	#instVars : [
		'groups',
		'currentGroup'
	],
	#classVars : [
		'Instance'
	],
	#category : #'ShellStone-Core'
}

{ #category : #accessing }
ShWorld class >> instance [
	Instance isNil ifTrue: [ Instance := self new ].
	^ Instance
]

{ #category : #accessing }
ShWorld class >> reset [
	Instance := nil
]

{ #category : #'instance creation' }
ShWorld class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShWorld >> initialize [
	groups := OrderedCollection new.
	currentGroup := nil
]

{ #category : #accessing }
ShWorld >> groups [
	^ groups
]

{ #category : #accessing }
ShWorld >> currentGroup [
	^ currentGroup
]

{ #category : #accessing }
ShWorld >> currentGroup: aGroup [
	currentGroup := aGroup
]

{ #category : #registering }
ShWorld >> register: aGroup [
	groups add: aGroup
]

{ #category : #clearing }
ShWorld >> clear [
	groups := OrderedCollection new.
	currentGroup := nil
]

{ #category : #accessing }
ShWorld >> allExamples [
	"Collect all examples from all groups"
	| all |
	all := OrderedCollection new.
	groups do: [ :group |
		all addAll: group allExamples
	].
	^ all
]

{ #category : #filtering }
ShWorld >> examplesWithTag: aSymbol [
	^ self allExamples select: [ :ex | ex hasTag: aSymbol ]
]

{ #category : #filtering }
ShWorld >> examplesMatching: aPattern [
	^ self allExamples select: [ :ex |
		ex fullDescription includesSubstring: aPattern
	]
]

{ #category : #running }
ShWorld >> runAll [
	| results |
	results := OrderedCollection new.
	groups do: [ :group |
		results addAll: group run
	].
	^ results
]

{ #category : #accessing }
ShWorld >> exampleCount [
	^ self allExamples size
]
