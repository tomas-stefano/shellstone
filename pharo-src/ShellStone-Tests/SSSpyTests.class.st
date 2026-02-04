"Tests for spies"
Class {
	#name : #SSSpyTests,
	#superclass : #TestCase,
	#category : #'ShellStone-Tests'
}

{ #category : #tests }
SSSpyTests >> testSpyForwardsToTarget [
	| list spy |
	list := OrderedCollection new.
	spy := SSSpy on: list.
	spy add: 1.
	spy add: 2.
	self assert: list size equals: 2.
	self assert: list first equals: 1
]

{ #category : #tests }
SSSpyTests >> testSpyRecordsCalls [
	| list spy |
	list := OrderedCollection new.
	spy := SSSpy on: list.
	spy add: 'item'.
	self assert: (spy received: #add:)
]

{ #category : #tests }
SSSpyTests >> testSpyRecordsCallCount [
	| list spy |
	list := OrderedCollection new.
	spy := SSSpy on: list.
	spy add: 1.
	spy add: 2.
	spy add: 3.
	self assert: (spy received: #add: times: 3)
]

{ #category : #tests }
SSSpyTests >> testSpyRecordsArgs [
	| list spy |
	list := OrderedCollection new.
	spy := SSSpy on: list.
	spy add: 'first'.
	spy add: 'second'.
	self assert: (spy received: #add: withArgs: #('first')).
	self assert: (spy received: #add: withArgs: #('second')).
	self deny: (spy received: #add: withArgs: #('third'))
]

{ #category : #tests }
SSSpyTests >> testSpyReset [
	| list spy |
	list := OrderedCollection new.
	spy := SSSpy on: list.
	spy add: 1.
	self assert: (spy received: #add:).
	spy reset.
	self deny: (spy received: #add:)
]
