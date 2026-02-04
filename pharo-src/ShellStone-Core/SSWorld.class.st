"Example group registry (World)"
Class {
	#name : #SSWorld,
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
SSWorld class >> instance [
	Instance isNil ifTrue: [ Instance := self new ].
	^ Instance
]

{ #category : #accessing }
SSWorld class >> reset [
	Instance := nil
]

{ #category : #'instance creation' }
SSWorld class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSWorld >> initialize [
	groups := OrderedCollection new.
	currentGroup := nil
]

{ #category : #accessing }
SSWorld >> groups [
	^ groups
]

{ #category : #accessing }
SSWorld >> currentGroup [
	^ currentGroup
]

{ #category : #accessing }
SSWorld >> currentGroup: aGroup [
	currentGroup := aGroup
]

{ #category : #registering }
SSWorld >> register: aGroup [
	groups add: aGroup
]

{ #category : #clearing }
SSWorld >> clear [
	groups := OrderedCollection new.
	currentGroup := nil
]

{ #category : #accessing }
SSWorld >> allExamples [
	"Collect all examples from all groups"
	| all |
	all := OrderedCollection new.
	groups do: [ :group |
		all addAll: group allExamples
	].
	^ all
]

{ #category : #filtering }
SSWorld >> examplesWithTag: aSymbol [
	^ self allExamples select: [ :ex | ex hasTag: aSymbol ]
]

{ #category : #filtering }
SSWorld >> examplesMatching: aPattern [
	^ self allExamples select: [ :ex |
		ex fullDescription includesSubstring: aPattern
	]
]

{ #category : #running }
SSWorld >> runAll [
	| results |
	results := OrderedCollection new.
	groups do: [ :group |
		results addAll: group run
	].
	^ results
]

{ #category : #accessing }
SSWorld >> exampleCount [
	^ self allExamples size
]
