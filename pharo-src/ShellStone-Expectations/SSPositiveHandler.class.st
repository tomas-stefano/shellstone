"Positive expectation handler - handles 'should' assertions"
Class {
	#name : #SSPositiveHandler,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
SSPositiveHandler class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
SSPositiveHandler >> actual [
	^ actual
]

{ #category : #accessing }
SSPositiveHandler >> actual: aValue [
	actual := aValue
]

{ #category : #handling }
SSPositiveHandler >> handleMatcher: aMatcher [
	"Core method to handle matcher evaluation"
	| result |
	result := aMatcher matchesWithNegation: actual.
	result ifFalse: [
		(SSExpectationFailed
			expected: aMatcher expected
			actual: actual
			matcher: aMatcher) signal
	].
	^ true
]

{ #category : #matchers }
SSPositiveHandler >> equal: expectedValue [
	^ self handleMatcher: (SSEqualMatcher expected: expectedValue)
]

{ #category : #matchers }
SSPositiveHandler >> be: aValue [
	^ self handleMatcher: (SSBeMatcher expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> beA: aClass [
	^ self handleMatcher: (SSBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
SSPositiveHandler >> beAn: aClass [
	^ self beA: aClass
]

{ #category : #matchers }
SSPositiveHandler >> beKindOf: aClass [
	^ self handleMatcher: (SSBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
SSPositiveHandler >> respondTo: aSelector [
	^ self handleMatcher: (SSRespondToMatcher expected: aSelector)
]

{ #category : #matchers }
SSPositiveHandler >> include: aValue [
	^ self handleMatcher: (SSIncludeMatcher expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> match: aPattern [
	^ self handleMatcher: (SSMatchMatcher expected: aPattern)
]

{ #category : #matchers }
SSPositiveHandler >> raiseError [
	^ self handleMatcher: SSRaiseErrorMatcher new
]

{ #category : #matchers }
SSPositiveHandler >> raiseError: anExceptionClass [
	^ self handleMatcher: (SSRaiseErrorMatcher expected: anExceptionClass)
]

{ #category : #matchers }
SSPositiveHandler >> beGreaterThan: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #> expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> beLessThan: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #< expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> beGreaterThanOrEqualTo: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #>= expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> beLessThanOrEqualTo: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #<= expected: aValue)
]

{ #category : #matchers }
SSPositiveHandler >> change: aBlock [
	^ SSChangeMatcher new
		actual: actual;
		receiver: aBlock;
		handler: self;
		yourself
]

{ #category : #matchers }
SSPositiveHandler >> beTruthy [
	^ self handleMatcher: SSBeMatcher forTruthy
]

{ #category : #matchers }
SSPositiveHandler >> beFalsy [
	^ self handleMatcher: SSBeMatcher forFalsy
]

{ #category : #matchers }
SSPositiveHandler >> beNil [
	^ self handleMatcher: SSBeMatcher forNil
]

{ #category : #matchers }
SSPositiveHandler >> beTrue [
	^ self handleMatcher: (SSEqualMatcher expected: true)
]

{ #category : #matchers }
SSPositiveHandler >> beFalse [
	^ self handleMatcher: (SSEqualMatcher expected: false)
]
