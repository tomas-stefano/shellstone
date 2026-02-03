"Tests for SSEqualMatcher"
Class {
	#name : #SSEqualMatcherTest,
	#superclass : #TestCase,
	#category : #'ShellStone-Tests'
}

{ #category : #tests }
SSEqualMatcherTest >> testMatchesEqualIntegers [
	| matcher |
	matcher := SSEqualMatcher expected: 42.
	self assert: (matcher matches: 42)
]

{ #category : #tests }
SSEqualMatcherTest >> testDoesNotMatchDifferentIntegers [
	| matcher |
	matcher := SSEqualMatcher expected: 42.
	self deny: (matcher matches: 43)
]

{ #category : #tests }
SSEqualMatcherTest >> testMatchesEqualStrings [
	| matcher |
	matcher := SSEqualMatcher expected: 'hello'.
	self assert: (matcher matches: 'hello')
]

{ #category : #tests }
SSEqualMatcherTest >> testMatchesEqualArrays [
	| matcher |
	matcher := SSEqualMatcher expected: #(1 2 3).
	self assert: (matcher matches: #(1 2 3))
]

{ #category : #tests }
SSEqualMatcherTest >> testPositiveFailureMessage [
	| matcher |
	matcher := SSEqualMatcher expected: 42.
	matcher matchesWithNegation: 43.
	self assert: (matcher failureMessage includesSubstring: '42').
	self assert: (matcher failureMessage includesSubstring: '43')
]

{ #category : #tests }
SSEqualMatcherTest >> testNegatedMatch [
	| matcher |
	matcher := SSEqualMatcher expected: 42.
	matcher negate.
	self assert: (matcher matchesWithNegation: 43).
	self deny: (matcher matchesWithNegation: 42)
]
