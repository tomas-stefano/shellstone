"Before/after hooks support"
Class {
	#name : #SSHook,
	#superclass : #Object,
	#instVars : [
		'scope',
		'block'
	],
	#category : #'ShellStone-Core'
}

{ #category : #'instance creation' }
SSHook class >> scope: aSymbol block: aBlock [
	^ self new
		scope: aSymbol;
		block: aBlock;
		yourself
]

{ #category : #accessing }
SSHook >> scope [
	^ scope
]

{ #category : #accessing }
SSHook >> scope: aSymbol [
	scope := aSymbol
]

{ #category : #accessing }
SSHook >> block [
	^ block
]

{ #category : #accessing }
SSHook >> block: aBlock [
	block := aBlock
]

{ #category : #running }
SSHook >> run [
	block value
]

{ #category : #testing }
SSHook >> isEach [
	^ scope = #each
]

{ #category : #testing }
SSHook >> isAll [
	^ scope = #all
]
