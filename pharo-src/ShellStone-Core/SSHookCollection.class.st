"Collection of before/after hooks"
Class {
	#name : #SSHookCollection,
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
SSHookCollection class >> new [
	^ super new initialize
]

{ #category : #initialization }
SSHookCollection >> initialize [
	beforeAll := OrderedCollection new.
	beforeEach := OrderedCollection new.
	afterAll := OrderedCollection new.
	afterEach := OrderedCollection new
]

{ #category : #accessing }
SSHookCollection >> beforeAll [
	^ beforeAll
]

{ #category : #accessing }
SSHookCollection >> beforeEach [
	^ beforeEach
]

{ #category : #accessing }
SSHookCollection >> afterAll [
	^ afterAll
]

{ #category : #accessing }
SSHookCollection >> afterEach [
	^ afterEach
]

{ #category : #adding }
SSHookCollection >> addBefore: aScope do: aBlock [
	| hook |
	hook := SSHook scope: aScope block: aBlock.
	aScope = #all
		ifTrue: [ beforeAll add: hook ]
		ifFalse: [ beforeEach add: hook ]
]

{ #category : #adding }
SSHookCollection >> addAfter: aScope do: aBlock [
	| hook |
	hook := SSHook scope: aScope block: aBlock.
	aScope = #all
		ifTrue: [ afterAll add: hook ]
		ifFalse: [ afterEach add: hook ]
]

{ #category : #running }
SSHookCollection >> runBeforeAll [
	beforeAll do: [ :hook | hook run ]
]

{ #category : #running }
SSHookCollection >> runBeforeEach [
	beforeEach do: [ :hook | hook run ]
]

{ #category : #running }
SSHookCollection >> runAfterAll [
	afterAll do: [ :hook | hook run ]
]

{ #category : #running }
SSHookCollection >> runAfterEach [
	afterEach do: [ :hook | hook run ]
]

{ #category : #merging }
SSHookCollection >> merge: aHookCollection [
	"Merge hooks from parent (parent hooks run first)"
	| merged |
	merged := SSHookCollection new.
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
