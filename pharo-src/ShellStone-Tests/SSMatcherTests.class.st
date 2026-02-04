"Tests for all matchers"
Class {
	#name : #SSMatcherTests,
	#superclass : #TestCase,
	#category : #'ShellStone-Tests'
}

{ #category : #'tests - comparison' }
SSMatcherTests >> testComparisonGreaterThan [
	| matcher |
	matcher := SSComparisonMatcher operator: #> expected: 5.
	self assert: (matcher matches: 10).
	self deny: (matcher matches: 3)
]

{ #category : #'tests - comparison' }
SSMatcherTests >> testComparisonLessThan [
	| matcher |
	matcher := SSComparisonMatcher operator: #< expected: 10.
	self assert: (matcher matches: 5).
	self deny: (matcher matches: 15)
]

{ #category : #'tests - be kind of' }
SSMatcherTests >> testBeKindOfString [
	| matcher |
	matcher := SSBeKindOfMatcher expected: String.
	self assert: (matcher matches: 'hello').
	self deny: (matcher matches: 42)
]

{ #category : #'tests - be kind of' }
SSMatcherTests >> testBeKindOfNumber [
	| matcher |
	matcher := SSBeKindOfMatcher expected: Number.
	self assert: (matcher matches: 42).
	self assert: (matcher matches: 3.14).
	self deny: (matcher matches: 'hello')
]

{ #category : #'tests - include' }
SSMatcherTests >> testIncludeInArray [
	| matcher |
	matcher := SSIncludeMatcher expected: 2.
	self assert: (matcher matches: #(1 2 3)).
	self deny: (matcher matches: #(1 3 5))
]

{ #category : #'tests - include' }
SSMatcherTests >> testIncludeInString [
	| matcher |
	matcher := SSIncludeMatcher expected: 'world'.
	self assert: (matcher matches: 'hello world').
	self deny: (matcher matches: 'hello there')
]

{ #category : #'tests - be' }
SSMatcherTests >> testBeTruthy [
	| matcher |
	matcher := SSBeMatcher forTruthy.
	self assert: (matcher matches: true).
	self assert: (matcher matches: 1).
	self assert: (matcher matches: 'text').
	self deny: (matcher matches: false).
	self deny: (matcher matches: nil)
]

{ #category : #'tests - be' }
SSMatcherTests >> testBeFalsy [
	| matcher |
	matcher := SSBeMatcher forFalsy.
	self assert: (matcher matches: false).
	self assert: (matcher matches: nil).
	self deny: (matcher matches: true).
	self deny: (matcher matches: 1)
]

{ #category : #'tests - be' }
SSMatcherTests >> testBeNil [
	| matcher |
	matcher := SSBeMatcher forNil.
	self assert: (matcher matches: nil).
	self deny: (matcher matches: 1).
	self deny: (matcher matches: false)
]

{ #category : #'tests - respond to' }
SSMatcherTests >> testRespondTo [
	| matcher |
	matcher := SSRespondToMatcher expected: #size.
	self assert: (matcher matches: 'hello').
	self assert: (matcher matches: #(1 2 3))
]

{ #category : #'tests - match' }
SSMatcherTests >> testMatch [
	| matcher |
	matcher := SSMatchMatcher expected: 'world'.
	self assert: (matcher matches: 'hello world').
	self deny: (matcher matches: 'hello there')
]

{ #category : #'tests - raise error' }
SSMatcherTests >> testRaiseError [
	| matcher |
	matcher := SSRaiseErrorMatcher new.
	self assert: (matcher matches: [ self error: 'boom' ]).
	self deny: (matcher matches: [ 1 + 1 ])
]

{ #category : #'tests - negation' }
SSMatcherTests >> testNegation [
	| matcher |
	matcher := SSEqualMatcher expected: 42.
	matcher negate.
	self assert: (matcher matchesWithNegation: 43).
	self deny: (matcher matchesWithNegation: 42)
]
