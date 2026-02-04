"Spy - wraps real object and records calls"
Class {
	#name : #ShSpy,
	#superclass : #Object,
	#instVars : [
		'target',
		'receivedMessages'
	],
	#category : #'ShellStone-Mocks'
}

{ #category : #'instance creation' }
ShSpy class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
ShSpy class >> on: anObject [
	^ self new target: anObject; yourself
]

{ #category : #initialization }
ShSpy >> initialize [
	receivedMessages := OrderedCollection new
]

{ #category : #accessing }
ShSpy >> target [
	^ target
]

{ #category : #accessing }
ShSpy >> target: anObject [
	target := anObject
]

{ #category : #accessing }
ShSpy >> receivedMessages [
	^ receivedMessages
]

{ #category : #'message handling' }
ShSpy >> doesNotUnderstand: aMessage [
	"Forward messages to target and record them"
	| selector args result |
	selector := aMessage selector.
	args := aMessage arguments.

	"Record the message"
	receivedMessages add: (Array with: selector with: args).

	"Forward to target"
	result := target perform: selector withArguments: args.
	^ result
]

{ #category : #verification }
ShSpy >> received: aSelector [
	^ receivedMessages anySatisfy: [ :msg | msg first = aSelector ]
]

{ #category : #verification }
ShSpy >> received: aSelector times: aCount [
	| count |
	count := receivedMessages count: [ :msg | msg first = aSelector ].
	^ count = aCount
]

{ #category : #verification }
ShSpy >> received: aSelector withArgs: anArray [
	^ receivedMessages anySatisfy: [ :msg |
		(msg first = aSelector) and: [ msg second = anArray ]
	]
]

{ #category : #accessing }
ShSpy >> callsTo: aSelector [
	^ receivedMessages select: [ :msg | msg first = aSelector ]
]

{ #category : #accessing }
ShSpy >> argsForCallTo: aSelector [
	| call |
	call := receivedMessages detect: [ :msg | msg first = aSelector ] ifNone: [ nil ].
	call isNil ifTrue: [ ^ nil ].
	^ call second
]

{ #category : #resetting }
ShSpy >> reset [
	receivedMessages := OrderedCollection new
]

{ #category : #printing }
ShSpy >> printOn: aStream [
	aStream nextPutAll: '#<Spy on: ', target printString, '>'
]
