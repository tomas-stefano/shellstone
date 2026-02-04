"Pending example support"
Class {
	#name : #SSPendingExample,
	#superclass : #Error,
	#instVars : [
		'message'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSPendingExample class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
SSPendingExample class >> message: aString [
	^ self new message: aString; yourself
]

{ #category : #initialization }
SSPendingExample >> initialize [
	message := 'Not yet implemented'
]

{ #category : #accessing }
SSPendingExample >> message [
	^ message
]

{ #category : #accessing }
SSPendingExample >> message: aString [
	message := aString
]

{ #category : #accessing }
SSPendingExample >> description [
	^ 'PendingExample'
]

{ #category : #accessing }
SSPendingExample >> messageText [
	^ message
]
