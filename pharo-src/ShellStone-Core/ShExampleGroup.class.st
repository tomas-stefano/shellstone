"Example group (describe/context block)"
Class {
	#name : #ShExampleGroup,
	#superclass : #Object,
	#instVars : [
		'description',
		'examples',
		'childGroups',
		'parent',
		'hooks',
		'lets',
		'metadata'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShExampleGroup class >> description: aString [
	^ self new description: aString; yourself
]

{ #category : #'instance creation' }
ShExampleGroup class >> description: aString parent: aGroup [
	^ self new
		description: aString;
		parent: aGroup;
		yourself
]

{ #category : #'instance creation' }
ShExampleGroup class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShExampleGroup >> initialize [
	examples := OrderedCollection new.
	childGroups := OrderedCollection new.
	hooks := ShHookCollection new.
	lets := ShLetContainer new.
	metadata := ShMetadata new
]

{ #category : #accessing }
ShExampleGroup >> description [
	^ description
]

{ #category : #accessing }
ShExampleGroup >> description: aString [
	description := aString
]

{ #category : #accessing }
ShExampleGroup >> examples [
	^ examples
]

{ #category : #accessing }
ShExampleGroup >> childGroups [
	^ childGroups
]

{ #category : #accessing }
ShExampleGroup >> parent [
	^ parent
]

{ #category : #accessing }
ShExampleGroup >> parent: aGroup [
	parent := aGroup
]

{ #category : #accessing }
ShExampleGroup >> hooks [
	^ hooks
]

{ #category : #accessing }
ShExampleGroup >> lets [
	^ lets
]

{ #category : #accessing }
ShExampleGroup >> metadata [
	^ metadata
]

{ #category : #accessing }
ShExampleGroup >> metadata: aMetadata [
	metadata := aMetadata
]

{ #category : #'dsl - examples' }
ShExampleGroup >> it: aDescription do: aBlock [
	| example |
	example := ShExample
		description: aDescription
		block: aBlock
		group: self.
	examples add: example.
	^ example
]

{ #category : #'dsl - examples' }
ShExampleGroup >> it: aDescription [
	"Pending example (no block)"
	| example |
	example := ShExample pending: aDescription.
	example group: self.
	examples add: example.
	^ example
]

{ #category : #'dsl - examples' }
ShExampleGroup >> it: aDescription tag: aTag do: aBlock [
	| example |
	example := self it: aDescription do: aBlock.
	example addTag: aTag.
	^ example
]

{ #category : #'dsl - examples' }
ShExampleGroup >> it: aDescription tags: aTags do: aBlock [
	| example |
	example := self it: aDescription do: aBlock.
	example addTags: aTags.
	^ example
]

{ #category : #'dsl - grouping' }
ShExampleGroup >> context: aDescription do: aBlock [
	| childGroup |
	childGroup := ShExampleGroup description: aDescription parent: self.
	childGroups add: childGroup.
	aBlock value: childGroup.
	^ childGroup
]

{ #category : #'dsl - grouping' }
ShExampleGroup >> describe: aDescription do: aBlock [
	"Alias for context"
	^ self context: aDescription do: aBlock
]

{ #category : #'dsl - hooks' }
ShExampleGroup >> before: aScope do: aBlock [
	hooks addBefore: aScope do: aBlock
]

{ #category : #'dsl - hooks' }
ShExampleGroup >> after: aScope do: aBlock [
	hooks addAfter: aScope do: aBlock
]

{ #category : #'dsl - let' }
ShExampleGroup >> let: aName do: aBlock [
	lets define: aName as: aBlock
]

{ #category : #'message handling' }
ShExampleGroup >> doesNotUnderstand: aMessage [
	"Access let values using dynamic method handling"
	| selector |
	selector := aMessage selector.
	(lets has: selector) ifTrue: [
		^ lets get: selector
	].
	parent isNil ifFalse: [
		^ parent doesNotUnderstand: aMessage
	].
	^ super doesNotUnderstand: aMessage
]

{ #category : #hierarchy }
ShExampleGroup >> descriptionParts [
	| parts |
	parts := OrderedCollection new.
	parent isNil ifFalse: [
		parts addAll: parent descriptionParts
	].
	parts add: description.
	^ parts
]

{ #category : #hierarchy }
ShExampleGroup >> fullDescription [
	| parts result |
	parts := self descriptionParts.
	result := WriteStream on: String new.
	parts doWithIndex: [ :part :idx |
		idx > 1 ifTrue: [ result nextPut: Character space ].
		result nextPutAll: part
	].
	^ result contents
]

{ #category : #hierarchy }
ShExampleGroup >> depth [
	parent isNil ifTrue: [ ^ 0 ].
	^ parent depth + 1
]

{ #category : #accessing }
ShExampleGroup >> allExamples [
	"Collect all examples including from child groups"
	| all |
	all := OrderedCollection new.
	all addAll: examples.
	childGroups do: [ :child |
		all addAll: child allExamples
	].
	^ all
]

{ #category : #hooks }
ShExampleGroup >> effectiveHooks [
	"Get merged hooks from parent chain"
	parent isNil ifTrue: [ ^ hooks ].
	^ hooks merge: parent effectiveHooks
]

{ #category : #lets }
ShExampleGroup >> effectiveLets [
	"Get merged lets from parent chain"
	| merged |
	merged := ShLetContainer new.
	parent isNil ifFalse: [
		merged merge: parent effectiveLets
	].
	merged merge: lets.
	^ merged
]

{ #category : #tags }
ShExampleGroup >> addTag: aSymbol [
	metadata addTag: aSymbol
]

{ #category : #tags }
ShExampleGroup >> addTags: aCollection [
	metadata addTags: aCollection
]

{ #category : #tags }
ShExampleGroup >> hasTag: aSymbol [
	^ metadata hasTag: aSymbol
]

{ #category : #running }
ShExampleGroup >> run [
	"Run all examples in this group"
	| results effectiveHooks effectiveLets |
	results := OrderedCollection new.
	effectiveHooks := self effectiveHooks.
	effectiveLets := self effectiveLets.

	effectiveHooks runBeforeAll.
	[
		examples do: [ :example |
			results add: (example runWithHooks: effectiveHooks lets: effectiveLets)
		].
		childGroups do: [ :child |
			results addAll: child run
		]
	] ensure: [
		effectiveHooks runAfterAll
	].
	^ results
]
