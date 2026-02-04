"Tests for test doubles"
Class {
	#name : #SSDoubleTests,
	#superclass : #TestCase,
	#category : #'ShellStone-Tests'
}

{ #category : #'tests - stubbing' }
SSDoubleTests >> testStubAndReturn [
	| double |
	double := SSDouble named: 'api'.
	double stub: #fetch andReturn: 'data'.
	self assert: double fetch equals: 'data'
]

{ #category : #'tests - stubbing' }
SSDoubleTests >> testStubWithArgs [
	| double |
	double := SSDouble named: 'calculator'.
	double stub: #add: andReturn: 42.
	self assert: (double add: 10) equals: 42
]

{ #category : #'tests - recording' }
SSDoubleTests >> testReceivedMessage [
	| double |
	double := SSDouble named: 'service'.
	double process.
	self assert: (double received: #process)
]

{ #category : #'tests - recording' }
SSDoubleTests >> testReceivedMessageWithCount [
	| double |
	double := SSDouble named: 'counter'.
	double increment.
	double increment.
	double increment.
	self assert: (double received: #increment times: 3)
]

{ #category : #'tests - recording' }
SSDoubleTests >> testReceivedMessageWithArgs [
	| double |
	double := SSDouble named: 'logger'.
	double log: 'info'.
	self assert: (double received: #log: withArgs: #('info'))
]

{ #category : #'tests - reset' }
SSDoubleTests >> testReset [
	| double |
	double := SSDouble named: 'service'.
	double stub: #fetch andReturn: 'data'.
	double fetch.
	self assert: (double received: #fetch).
	double reset.
	self deny: (double received: #fetch)
]
