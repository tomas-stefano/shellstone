"Test doubles"
Class {
	#name : #ShDouble,
	#superclass : #Object,
	#instVars : [
		'name',
		'stubs',
		'messageExpectations',
		'receivedMessages'
	],
	#category : #'ShellStone-Mocks'
}

{ #category : #'instance creation' }
ShDouble class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
ShDouble class >> named: aString [
	^ self new name: aString; yourself
]

{ #category : #initialization }
ShDouble >> initialize [
	name := 'double'.
	stubs := Dictionary new.
	messageExpectations := OrderedCollection new.
	receivedMessages := OrderedCollection new
]

{ #category : #accessing }
ShDouble >> name [
	^ name
]

{ #category : #accessing }
ShDouble >> name: aString [
	name := aString
]

{ #category : #accessing }
ShDouble >> stubs [
	^ stubs
]

{ #category : #accessing }
ShDouble >> messageExpectations [
	^ messageExpectations
]

{ #category : #accessing }
ShDouble >> receivedMessages [
	^ receivedMessages
]

{ #category : #stubbing }
ShDouble >> stub: aSelector [
	^ ShMethodStub new
		double: self;
		selector: aSelector;
		yourself
]

{ #category : #stubbing }
ShDouble >> stub: aSelector andReturn: aValue [
	| stub |
	stub := self stub: aSelector.
	stub returnValue: aValue.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #stubbing }
ShDouble >> stub: aSelector andDo: aBlock [
	| stub |
	stub := self stub: aSelector.
	stub block: aBlock.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #stubbing }
ShDouble >> stub: aSelector andRaise: anException [
	| stub |
	stub := self stub: aSelector.
	stub exception: anException.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #expectations }
ShDouble >> shouldReceive: aSelector [
	| expectation |
	expectation := ShMessageExpectation new
		double: self;
		selector: aSelector;
		yourself.
	messageExpectations add: expectation.
	^ expectation
]

{ #category : #expectations }
ShDouble >> shouldReceive: aSelector withArgs: anArray [
	| expectation |
	expectation := self shouldReceive: aSelector.
	expectation expectedArgs: anArray.
	^ expectation
]

{ #category : #'message handling' }
ShDouble >> doesNotUnderstand: aMessage [
	| selector args stub |
	selector := aMessage selector.
	args := aMessage arguments.

	"Record the message"
	receivedMessages add: (Array with: selector with: args).

	"Check for stub"
	stub := stubs at: selector ifAbsent: [ nil ].
	stub notNil ifTrue: [
		^ stub valueWithArgs: args
	].

	"Check for expectation with return value"
	messageExpectations do: [ :exp |
		(exp selector = selector) ifTrue: [
			exp recordCall: args.
			exp returnValue notNil ifTrue: [ ^ exp returnValue ]
		]
	].

	"No stub found, return nil by default"
	^ nil
]

{ #category : #verification }
ShDouble >> verify [
	messageExpectations do: [ :exp |
		exp verify
	]
]

{ #category : #verification }
ShDouble >> received: aSelector [
	^ receivedMessages anySatisfy: [ :msg | msg first = aSelector ]
]

{ #category : #verification }
ShDouble >> received: aSelector times: aCount [
	| count |
	count := receivedMessages count: [ :msg | msg first = aSelector ].
	^ count = aCount
]

{ #category : #verification }
ShDouble >> received: aSelector withArgs: anArray [
	^ receivedMessages anySatisfy: [ :msg |
		(msg first = aSelector) and: [ msg second = anArray ]
	]
]

{ #category : #resetting }
ShDouble >> reset [
	stubs := Dictionary new.
	messageExpectations := OrderedCollection new.
	receivedMessages := OrderedCollection new
]

{ #category : #printing }
ShDouble >> printOn: aStream [
	aStream nextPutAll: '#<Double:', name, '>'
]
