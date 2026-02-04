"Collection of before/after hooks"
Class {
	#name : #ShHookCollection,
	#superclass : #Object,
	#instVars : [
		'beforeAll',
		'beforeEach',
		'afterAll',
		'afterEach'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShHookCollection class >> new [
	^ super new initialize
]

{ #category : #initialization }
ShHookCollection >> initialize [
	beforeAll := OrderedCollection new.
	beforeEach := OrderedCollection new.
	afterAll := OrderedCollection new.
	afterEach := OrderedCollection new
]

{ #category : #accessing }
ShHookCollection >> beforeAll [
	^ beforeAll
]

{ #category : #accessing }
ShHookCollection >> beforeEach [
	^ beforeEach
]

{ #category : #accessing }
ShHookCollection >> afterAll [
	^ afterAll
]

{ #category : #accessing }
ShHookCollection >> afterEach [
	^ afterEach
]

{ #category : #adding }
ShHookCollection >> addBefore: aScope do: aBlock [
	| hook |
	hook := ShHook scope: aScope block: aBlock.
	aScope = #all
		ifTrue: [ beforeAll add: hook ]
		ifFalse: [ beforeEach add: hook ]
]

{ #category : #adding }
ShHookCollection >> addAfter: aScope do: aBlock [
	| hook |
	hook := ShHook scope: aScope block: aBlock.
	aScope = #all
		ifTrue: [ afterAll add: hook ]
		ifFalse: [ afterEach add: hook ]
]

{ #category : #running }
ShHookCollection >> runBeforeAll [
	beforeAll do: [ :hook | hook run ]
]

{ #category : #running }
ShHookCollection >> runBeforeEach [
	beforeEach do: [ :hook | hook run ]
]

{ #category : #running }
ShHookCollection >> runAfterAll [
	afterAll do: [ :hook | hook run ]
]

{ #category : #running }
ShHookCollection >> runAfterEach [
	afterEach do: [ :hook | hook run ]
]

{ #category : #merging }
ShHookCollection >> merge: aHookCollection [
	"Merge hooks from parent (parent hooks run first)"
	| merged |
	merged := ShHookCollection new.
	"Parent before hooks run first"
	aHookCollection beforeAll do: [ :h | merged beforeAll add: h ].
	beforeAll do: [ :h | merged beforeAll add: h ].
	aHookCollection beforeEach do: [ :h | merged beforeEach add: h ].
	beforeEach do: [ :h | merged beforeEach add: h ].
	"Child after hooks run first (reverse order)"
	afterAll do: [ :h | merged afterAll add: h ].
	aHookCollection afterAll do: [ :h | merged afterAll add: h ].
	afterEach do: [ :h | merged afterEach add: h ].
	aHookCollection afterEach do: [ :h | merged afterEach add: h ].
	^ merged
]
