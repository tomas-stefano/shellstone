"Individual test case (it block)"
Class {
	#name : #SSExample,
	#superclass : #Object,
	#instVars : [
		'description',
		'block',
		'group',
		'metadata',
		'pending',
		'pendingMessage'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSExample class >> description: aString block: aBlock [
	^ self new
		description: aString;
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
SSExample class >> description: aString block: aBlock group: aGroup [
	^ self new
		description: aString;
		block: aBlock;
		group: aGroup;
		yourself
]

{ #category : #'instance creation' }
SSExample class >> pending: aString [
	^ self new
		description: aString;
		pending: true;
		yourself
]

{ #category : #'instance creation' }
SSExample class >> pending: aString message: aMessage [
	^ self new
		description: aString;
		pending: true;
		pendingMessage: aMessage;
		yourself
]

{ #category : #'instance creation' }
SSExample class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSExample >> initialize [
	metadata := SSMetadata new.
	pending := false
]

{ #category : #accessing }
SSExample >> description [
	^ description
]

{ #category : #accessing }
SSExample >> description: aString [
	description := aString
]

{ #category : #accessing }
SSExample >> block [
	^ block
]

{ #category : #accessing }
SSExample >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
SSExample >> group [
	^ group
]

{ #category : #accessing }
SSExample >> group: aGroup [
	group := aGroup
]

{ #category : #accessing }
SSExample >> metadata [
	^ metadata
]

{ #category : #accessing }
SSExample >> metadata: aMetadata [
	metadata := aMetadata
]

{ #category : #accessing }
SSExample >> pending [
	^ pending
]

{ #category : #accessing }
SSExample >> pending: aBoolean [
	pending := aBoolean
]

{ #category : #accessing }
SSExample >> pendingMessage [
	^ pendingMessage
]

{ #category : #accessing }
SSExample >> pendingMessage: aString [
	pendingMessage := aString
]

{ #category : #testing }
SSExample >> isPending [
	^ pending or: [ block isNil ]
]

{ #category : #accessing }
SSExample >> fullDescription [
	"Build full description from group hierarchy"
	| parts result |
	parts := OrderedCollection new.
	group isNil ifFalse: [
		parts addAll: group descriptionParts
	].
	parts add: description.
	result := WriteStream on: String new.
	parts doWithIndex: [ :part :idx |
		idx > 1 ifTrue: [ result nextPut: Character space ].
		result nextPutAll: part
	].
	^ result contents
]

{ #category : #accessing }
SSExample >> location [
	^ metadata fullLocation
]

{ #category : #tags }
SSExample >> addTag: aSymbol [
	metadata addTag: aSymbol
]

{ #category : #tags }
SSExample >> addTags: aCollection [
	metadata addTags: aCollection
]

{ #category : #tags }
SSExample >> hasTag: aSymbol [
	^ metadata hasTag: aSymbol
]

{ #category : #running }
SSExample >> run [
	"Execute the example"
	self isPending ifTrue: [
		^ SSExampleResult pending: self
	].
	^ [
		block value.
		SSExampleResult passed: self
	] on: SSExpectationFailed do: [ :ex |
		SSExampleResult failed: self exception: ex
	] on: SSPendingExample do: [ :ex |
		SSExampleResult pending: self
	] on: Error do: [ :ex |
		SSExampleResult failed: self exception: ex
	]
]

{ #category : #running }
SSExample >> runWithHooks: aHookCollection lets: aLetContainer [
	"Execute example with hooks and let bindings"
	| result |
	self isPending ifTrue: [
		^ SSExampleResult pending: self
	].
	result := nil.
	[
		aHookCollection runBeforeEach.
		result := [
			block value.
			SSExampleResult passed: self
		] on: SSExpectationFailed do: [ :ex |
			SSExampleResult failed: self exception: ex
		] on: SSPendingExample do: [ :ex |
			SSExampleResult pending: self
		] on: Error do: [ :ex |
			SSExampleResult failed: self exception: ex
		]
	] ensure: [
		aLetContainer reset.
		aHookCollection runAfterEach
	].
	^ result
]
