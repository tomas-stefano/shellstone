"Before/after hooks support"
Class {
	#name : #ShHook,
	#superclass : #Object,
	#instVars : [
		'scope',
		'block'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
ShHook class >> scope: aSymbol block: aBlock [
	^ self new
		scope: aSymbol;
		block: aBlock;
		yourself
]

{ #category : #accessing }
ShHook >> scope [
	^ scope
]

{ #category : #accessing }
ShHook >> scope: aSymbol [
	scope := aSymbol
]

{ #category : #accessing }
ShHook >> block [
	^ block
]

{ #category : #accessing }
ShHook >> block: aBlock [
	block := aBlock
]

{ #category : #running }
ShHook >> run [
	block value
]

{ #category : #testing }
ShHook >> isEach [
	^ scope = #each
]

{ #category : #testing }
ShHook >> isAll [
	^ scope = #all
]
