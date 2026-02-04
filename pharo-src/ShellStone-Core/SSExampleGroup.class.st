"Example group (describe/context block)"
Class {
	#name : #SSExampleGroup,
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
SSExampleGroup class >> description: aString [
	^ self new description: aString; yourself
]

{ #category : #'instance creation' }
SSExampleGroup class >> description: aString parent: aGroup [
	^ self new
		description: aString;
		parent: aGroup;
		yourself
]

{ #category : #'instance creation' }
SSExampleGroup class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSExampleGroup >> initialize [
	examples := OrderedCollection new.
	childGroups := OrderedCollection new.
	hooks := SSHookCollection new.
	lets := SSLetContainer new.
	metadata := SSMetadata new
]

{ #category : #accessing }
SSExampleGroup >> description [
	^ description
]

{ #category : #accessing }
SSExampleGroup >> description: aString [
	description := aString
]

{ #category : #accessing }
SSExampleGroup >> examples [
	^ examples
]

{ #category : #accessing }
SSExampleGroup >> childGroups [
	^ childGroups
]

{ #category : #accessing }
SSExampleGroup >> parent [
	^ parent
]

{ #category : #accessing }
SSExampleGroup >> parent: aGroup [
	parent := aGroup
]

{ #category : #accessing }
SSExampleGroup >> hooks [
	^ hooks
]

{ #category : #accessing }
SSExampleGroup >> lets [
	^ lets
]

{ #category : #accessing }
SSExampleGroup >> metadata [
	^ metadata
]

{ #category : #accessing }
SSExampleGroup >> metadata: aMetadata [
	metadata := aMetadata
]

{ #category : #'dsl - examples' }
SSExampleGroup >> it: aDescription do: aBlock [
	| example |
	example := SSExample
		description: aDescription
		block: aBlock
		group: self.
	examples add: example.
	^ example
]

{ #category : #'dsl - examples' }
SSExampleGroup >> it: aDescription [
	"Pending example (no block)"
	| example |
	example := SSExample pending: aDescription.
	example group: self.
	examples add: example.
	^ example
]

{ #category : #'dsl - examples' }
SSExampleGroup >> it: aDescription tag: aTag do: aBlock [
	| example |
	example := self it: aDescription do: aBlock.
	example addTag: aTag.
	^ example
]

{ #category : #'dsl - examples' }
SSExampleGroup >> it: aDescription tags: aTags do: aBlock [
	| example |
	example := self it: aDescription do: aBlock.
	example addTags: aTags.
	^ example
]

{ #category : #'dsl - grouping' }
SSExampleGroup >> context: aDescription do: aBlock [
	| childGroup |
	childGroup := SSExampleGroup description: aDescription parent: self.
	childGroups add: childGroup.
	aBlock value: childGroup.
	^ childGroup
]

{ #category : #'dsl - grouping' }
SSExampleGroup >> describe: aDescription do: aBlock [
	"Alias for context"
	^ self context: aDescription do: aBlock
]

{ #category : #'dsl - hooks' }
SSExampleGroup >> before: aScope do: aBlock [
	hooks addBefore: aScope do: aBlock
]

{ #category : #'dsl - hooks' }
SSExampleGroup >> after: aScope do: aBlock [
	hooks addAfter: aScope do: aBlock
]

{ #category : #'dsl - let' }
SSExampleGroup >> let: aName do: aBlock [
	lets define: aName as: aBlock
]

{ #category : #'message handling' }
SSExampleGroup >> doesNotUnderstand: aMessage [
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
SSExampleGroup >> descriptionParts [
	| parts |
	parts := OrderedCollection new.
	parent isNil ifFalse: [
		parts addAll: parent descriptionParts
	].
	parts add: description.
	^ parts
]

{ #category : #hierarchy }
SSExampleGroup >> fullDescription [
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
SSExampleGroup >> depth [
	parent isNil ifTrue: [ ^ 0 ].
	^ parent depth + 1
]

{ #category : #accessing }
SSExampleGroup >> allExamples [
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
SSExampleGroup >> effectiveHooks [
	"Get merged hooks from parent chain"
	parent isNil ifTrue: [ ^ hooks ].
	^ hooks merge: parent effectiveHooks
]

{ #category : #lets }
SSExampleGroup >> effectiveLets [
	"Get merged lets from parent chain"
	| merged |
	merged := SSLetContainer new.
	parent isNil ifFalse: [
		merged merge: parent effectiveLets
	].
	merged merge: lets.
	^ merged
]

{ #category : #tags }
SSExampleGroup >> addTag: aSymbol [
	metadata addTag: aSymbol
]

{ #category : #tags }
SSExampleGroup >> addTags: aCollection [
	metadata addTags: aCollection
]

{ #category : #tags }
SSExampleGroup >> hasTag: aSymbol [
	^ metadata hasTag: aSymbol
]

{ #category : #running }
SSExampleGroup >> run [
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
