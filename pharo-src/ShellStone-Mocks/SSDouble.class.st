"Test doubles"
Class {
	#name : #SSDouble,
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
SSDouble class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
SSDouble class >> named: aString [
	^ self new name: aString; yourself
]

{ #category : #initialization }
SSDouble >> initialize [
	name := 'double'.
	stubs := Dictionary new.
	messageExpectations := OrderedCollection new.
	receivedMessages := OrderedCollection new
]

{ #category : #accessing }
SSDouble >> name [
	^ name
]

{ #category : #accessing }
SSDouble >> name: aString [
	name := aString
]

{ #category : #accessing }
SSDouble >> stubs [
	^ stubs
]

{ #category : #accessing }
SSDouble >> messageExpectations [
	^ messageExpectations
]

{ #category : #accessing }
SSDouble >> receivedMessages [
	^ receivedMessages
]

{ #category : #stubbing }
SSDouble >> stub: aSelector [
	^ SSMethodStub new
		double: self;
		selector: aSelector;
		yourself
]

{ #category : #stubbing }
SSDouble >> stub: aSelector andReturn: aValue [
	| stub |
	stub := self stub: aSelector.
	stub returnValue: aValue.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #stubbing }
SSDouble >> stub: aSelector andDo: aBlock [
	| stub |
	stub := self stub: aSelector.
	stub block: aBlock.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #stubbing }
SSDouble >> stub: aSelector andRaise: anException [
	| stub |
	stub := self stub: aSelector.
	stub exception: anException.
	stubs at: aSelector put: stub.
	^ stub
]

{ #category : #expectations }
SSDouble >> shouldReceive: aSelector [
	| expectation |
	expectation := SSMessageExpectation new
		double: self;
		selector: aSelector;
		yourself.
	messageExpectations add: expectation.
	^ expectation
]

{ #category : #expectations }
SSDouble >> shouldReceive: aSelector withArgs: anArray [
	| expectation |
	expectation := self shouldReceive: aSelector.
	expectation expectedArgs: anArray.
	^ expectation
]

{ #category : #'message handling' }
SSDouble >> doesNotUnderstand: aMessage [
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
SSDouble >> verify [
	messageExpectations do: [ :exp |
		exp verify
	]
]

{ #category : #verification }
SSDouble >> received: aSelector [
	^ receivedMessages anySatisfy: [ :msg | msg first = aSelector ]
]

{ #category : #verification }
SSDouble >> received: aSelector times: aCount [
	| count |
	count := receivedMessages count: [ :msg | msg first = aSelector ].
	^ count = aCount
]

{ #category : #verification }
SSDouble >> received: aSelector withArgs: anArray [
	^ receivedMessages anySatisfy: [ :msg |
		(msg first = aSelector) and: [ msg second = anArray ]
	]
]

{ #category : #resetting }
SSDouble >> reset [
	stubs := Dictionary new.
	messageExpectations := OrderedCollection new.
	receivedMessages := OrderedCollection new
]

{ #category : #printing }
SSDouble >> printOn: aStream [
	aStream nextPutAll: '#<Double:', name, '>'
]
