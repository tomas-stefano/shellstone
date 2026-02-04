"Negative expectation handler - handles 'should_not' assertions"
Class {
	#name : #SSNegativeHandler,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
SSNegativeHandler class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
SSNegativeHandler >> actual [
	^ actual
]

{ #category : #accessing }
SSNegativeHandler >> actual: aValue [
	actual := aValue
]

{ #category : #handling }
SSNegativeHandler >> handleMatcher: aMatcher [
	"Core method to handle matcher evaluation with negation"
	| result |
	aMatcher negate.
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
SSNegativeHandler >> equal: expectedValue [
	^ self handleMatcher: (SSEqualMatcher expected: expectedValue)
]

{ #category : #matchers }
SSNegativeHandler >> be: aValue [
	^ self handleMatcher: (SSBeMatcher expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> beA: aClass [
	^ self handleMatcher: (SSBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
SSNegativeHandler >> beAn: aClass [
	^ self beA: aClass
]

{ #category : #matchers }
SSNegativeHandler >> beKindOf: aClass [
	^ self handleMatcher: (SSBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
SSNegativeHandler >> respondTo: aSelector [
	^ self handleMatcher: (SSRespondToMatcher expected: aSelector)
]

{ #category : #matchers }
SSNegativeHandler >> include: aValue [
	^ self handleMatcher: (SSIncludeMatcher expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> match: aPattern [
	^ self handleMatcher: (SSMatchMatcher expected: aPattern)
]

{ #category : #matchers }
SSNegativeHandler >> raiseError [
	^ self handleMatcher: SSRaiseErrorMatcher new
]

{ #category : #matchers }
SSNegativeHandler >> raiseError: anExceptionClass [
	^ self handleMatcher: (SSRaiseErrorMatcher expected: anExceptionClass)
]

{ #category : #matchers }
SSNegativeHandler >> beGreaterThan: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #> expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> beLessThan: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #< expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> beGreaterThanOrEqualTo: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #>= expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> beLessThanOrEqualTo: aValue [
	^ self handleMatcher: (SSComparisonMatcher operator: #<= expected: aValue)
]

{ #category : #matchers }
SSNegativeHandler >> beTruthy [
	^ self handleMatcher: SSBeMatcher forTruthy
]

{ #category : #matchers }
SSNegativeHandler >> beFalsy [
	^ self handleMatcher: SSBeMatcher forFalsy
]

{ #category : #matchers }
SSNegativeHandler >> beNil [
	^ self handleMatcher: SSBeMatcher forNil
]

{ #category : #matchers }
SSNegativeHandler >> beTrue [
	^ self handleMatcher: (SSEqualMatcher expected: true)
]

{ #category : #matchers }
SSNegativeHandler >> beFalse [
	^ self handleMatcher: (SSEqualMatcher expected: false)
]
