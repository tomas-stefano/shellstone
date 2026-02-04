"Bridge to run ShellStone specs through SUnit"
Class {
	#name : #ShSpecRunner,
	#superclass : #TestCase,
	#instVars : [
		'currentExample'
	],
	#classVars : [
		'Examples'
	],
	#category : #'ShellStone-Support'
}

{ #category : #accessing }
ShSpecRunner class >> examples [
	^ Examples ifNil: [ Examples := OrderedCollection new ]
]

{ #category : #accessing }
ShSpecRunner class >> examples: aCollection [
	Examples := aCollection
]

{ #category : #running }
ShSpecRunner class >> buildSuiteFromMethods [
	"Build test suite from registered examples instead of methods"
	| suite |
	suite := TestSuite named: self name.
	self loadSpecs.
	self examples doWithIndex: [ :example :index |
		| testCase |
		testCase := self new.
		testCase setTestSelector: ('test', index asString) asSymbol.
		testCase currentExample: example.
		suite addTest: testCase
	].
	^ suite
]

{ #category : #running }
ShSpecRunner class >> loadSpecs [
	"Override in subclass to load spec files"
	ShWorld reset
]

{ #category : #running }
ShSpecRunner class >> collectExamples [
	"Collect all examples from ShWorld"
	Examples := ShWorld instance allExamples
]

{ #category : #accessing }
ShSpecRunner >> currentExample [
	^ currentExample
]

{ #category : #accessing }
ShSpecRunner >> currentExample: anExample [
	currentExample := anExample
]

{ #category : #running }
ShSpecRunner >> runCase [
	"Run the current example with hooks from its group"
	| result effectiveHooks effectiveLets |
	currentExample ifNil: [ ^ self ].

	currentExample isPending ifTrue: [
		"Skip pending examples"
		^ self
	].

	"Get effective hooks and lets from example's group hierarchy"
	effectiveHooks := currentExample group
		ifNil: [ ShHookCollection new ]
		ifNotNil: [ :g | g effectiveHooks ].
	effectiveLets := currentExample group
		ifNil: [ ShLetContainer new ]
		ifNotNil: [ :g | g effectiveLets ].

	result := currentExample runWithHooks: effectiveHooks lets: effectiveLets.
	result failed ifTrue: [
		self fail: result failureMessage
	]
]

{ #category : #printing }
ShSpecRunner >> printOn: aStream [
	aStream nextPutAll: (currentExample
		ifNil: [ self class name ]
		ifNotNil: [ currentExample fullDescription ])
]
