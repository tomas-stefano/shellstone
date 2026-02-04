"Bridge to run ShellStone specs through SUnit"
Class {
	#name : #SSSpecRunner,
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
SSSpecRunner class >> examples [
	^ Examples ifNil: [ Examples := OrderedCollection new ]
]

{ #category : #accessing }
SSSpecRunner class >> examples: aCollection [
	Examples := aCollection
]

{ #category : #running }
SSSpecRunner class >> buildSuiteFromMethods [
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
SSSpecRunner class >> loadSpecs [
	"Override in subclass to load spec files"
	SSWorld reset
]

{ #category : #running }
SSSpecRunner class >> collectExamples [
	"Collect all examples from SSWorld"
	Examples := SSWorld instance allExamples
]

{ #category : #accessing }
SSSpecRunner >> currentExample [
	^ currentExample
]

{ #category : #accessing }
SSSpecRunner >> currentExample: anExample [
	currentExample := anExample
]

{ #category : #running }
SSSpecRunner >> runCase [
	"Run the current example"
	| result |
	currentExample ifNil: [ ^ self ].

	currentExample isPending ifTrue: [
		"Skip pending examples"
		^ self
	].

	result := currentExample run.
	result failed ifTrue: [
		self fail: result failureMessage
	]
]

{ #category : #printing }
SSSpecRunner >> printOn: aStream [
	aStream nextPutAll: (currentExample
		ifNil: [ self class name ]
		ifNotNil: [ currentExample fullDescription ])
]
