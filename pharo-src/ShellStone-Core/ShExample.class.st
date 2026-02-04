"Individual test case (it block)"
Class {
	#name : #ShExample,
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
ShExample class >> description: aString block: aBlock [
	^ self new
		description: aString;
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
ShExample class >> description: aString block: aBlock group: aGroup [
	^ self new
		description: aString;
		block: aBlock;
		group: aGroup;
		yourself
]

{ #category : #'instance creation' }
ShExample class >> pending: aString [
	^ self new
		description: aString;
		pending: true;
		yourself
]

{ #category : #'instance creation' }
ShExample class >> pending: aString message: aMessage [
	^ self new
		description: aString;
		pending: true;
		pendingMessage: aMessage;
		yourself
]

{ #category : #'instance creation' }
ShExample class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShExample >> initialize [
	metadata := ShMetadata new.
	pending := false
]

{ #category : #accessing }
ShExample >> description [
	^ description
]

{ #category : #accessing }
ShExample >> description: aString [
	description := aString
]

{ #category : #accessing }
ShExample >> block [
	^ block
]

{ #category : #accessing }
ShExample >> block: aBlock [
	block := aBlock
]

{ #category : #accessing }
ShExample >> group [
	^ group
]

{ #category : #accessing }
ShExample >> group: aGroup [
	group := aGroup
]

{ #category : #accessing }
ShExample >> metadata [
	^ metadata
]

{ #category : #accessing }
ShExample >> metadata: aMetadata [
	metadata := aMetadata
]

{ #category : #accessing }
ShExample >> pending [
	^ pending
]

{ #category : #accessing }
ShExample >> pending: aBoolean [
	pending := aBoolean
]

{ #category : #accessing }
ShExample >> pendingMessage [
	^ pendingMessage
]

{ #category : #accessing }
ShExample >> pendingMessage: aString [
	pendingMessage := aString
]

{ #category : #testing }
ShExample >> isPending [
	^ pending or: [ block isNil ]
]

{ #category : #accessing }
ShExample >> fullDescription [
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
ShExample >> location [
	^ metadata fullLocation
]

{ #category : #tags }
ShExample >> addTag: aSymbol [
	metadata addTag: aSymbol
]

{ #category : #tags }
ShExample >> addTags: aCollection [
	metadata addTags: aCollection
]

{ #category : #tags }
ShExample >> hasTag: aSymbol [
	^ metadata hasTag: aSymbol
]

{ #category : #running }
ShExample >> run [
	"Execute the example"
	self isPending ifTrue: [
		^ ShExampleResult pending: self
	].
	^ [
		block value.
		ShExampleResult passed: self
	] on: ShExpectationFailed, ShPendingExample, Error do: [ :ex |
		(ex isKindOf: ShPendingExample)
			ifTrue: [ ShExampleResult pending: self ]
			ifFalse: [ ShExampleResult failed: self exception: ex ]
	]
]

{ #category : #running }
ShExample >> runWithHooks: aHookCollection lets: aLetContainer [
	"Execute example with hooks and let bindings"
	| result |
	self isPending ifTrue: [
		^ ShExampleResult pending: self
	].
	result := nil.
	[
		aHookCollection runBeforeEach.
		result := [
			block value.
			ShExampleResult passed: self
		] on: ShExpectationFailed, ShPendingExample, Error do: [ :ex |
			(ex isKindOf: ShPendingExample)
				ifTrue: [ ShExampleResult pending: self ]
				ifFalse: [ ShExampleResult failed: self exception: ex ]
		]
	] ensure: [
		aLetContainer reset.
		aHookCollection runAfterEach
	].
	^ result
]
