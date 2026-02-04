"Spy - wraps real object and records calls"
Class {
	#name : #SSSpy,
	#superclass : #Object,
	#instVars : [
		'target',
		'receivedMessages'
	],
	#category : #'ShellStone-Mocks'
}

{ #category : #'instance creation' }
SSSpy class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
SSSpy class >> on: anObject [
	^ self new target: anObject; yourself
]

{ #category : #initialization }
SSSpy >> initialize [
	receivedMessages := OrderedCollection new
]

{ #category : #accessing }
SSSpy >> target [
	^ target
]

{ #category : #accessing }
SSSpy >> target: anObject [
	target := anObject
]

{ #category : #accessing }
SSSpy >> receivedMessages [
	^ receivedMessages
]

{ #category : #'message handling' }
SSSpy >> doesNotUnderstand: aMessage [
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
SSSpy >> received: aSelector [
	^ receivedMessages anySatisfy: [ :msg | msg first = aSelector ]
]

{ #category : #verification }
SSSpy >> received: aSelector times: aCount [
	| count |
	count := receivedMessages count: [ :msg | msg first = aSelector ].
	^ count = aCount
]

{ #category : #verification }
SSSpy >> received: aSelector withArgs: anArray [
	^ receivedMessages anySatisfy: [ :msg |
		(msg first = aSelector) and: [ msg second = anArray ]
	]
]

{ #category : #accessing }
SSSpy >> callsTo: aSelector [
	^ receivedMessages select: [ :msg | msg first = aSelector ]
]

{ #category : #accessing }
SSSpy >> argsForCallTo: aSelector [
	| call |
	call := receivedMessages detect: [ :msg | msg first = aSelector ] ifNone: [ nil ].
	call isNil ifTrue: [ ^ nil ].
	^ call second
]

{ #category : #resetting }
SSSpy >> reset [
	receivedMessages := OrderedCollection new
]

{ #category : #printing }
SSSpy >> printOn: aStream [
	aStream nextPutAll: '#<Spy on: ', target printString, '>'
]
