"Pending example support"
Class {
	#name : #ShPendingExample,
	#superclass : #Error,
	#instVars : [
		'message'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShPendingExample class >> new [
	^ super new initialize
]

{ #category : #'instance creation' }
ShPendingExample class >> message: aString [
	^ self new message: aString; yourself
]

{ #category : #initialization }
ShPendingExample >> initialize [
	message := 'Not yet implemented'
]

{ #category : #accessing }
ShPendingExample >> message [
	^ message
]

{ #category : #accessing }
ShPendingExample >> message: aString [
	message := aString
]

{ #category : #accessing }
ShPendingExample >> description [
	^ 'PendingExample'
]

{ #category : #accessing }
ShPendingExample >> messageText [
	^ message
]
