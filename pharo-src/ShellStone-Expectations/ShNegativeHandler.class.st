"Negative expectation handler - handles 'should_not' assertions"
Class {
	#name : #ShNegativeHandler,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
ShNegativeHandler class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
ShNegativeHandler >> actual [
	^ actual
]

{ #category : #accessing }
ShNegativeHandler >> actual: aValue [
	actual := aValue
]

{ #category : #handling }
ShNegativeHandler >> handleMatcher: aMatcher [
	"Core method to handle matcher evaluation with negation"
	| result |
	aMatcher negate.
	result := aMatcher matchesWithNegation: actual.
	result ifFalse: [
		(ShExpectationFailed
			expected: aMatcher expected
			actual: actual
			matcher: aMatcher) signal
	].
	^ true
]

{ #category : #matchers }
ShNegativeHandler >> equal: expectedValue [
	^ self handleMatcher: (ShEqualMatcher expected: expectedValue)
]

{ #category : #matchers }
ShNegativeHandler >> be: aValue [
	^ self handleMatcher: (ShBeMatcher expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> beA: aClass [
	^ self handleMatcher: (ShBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
ShNegativeHandler >> beAn: aClass [
	^ self beA: aClass
]

{ #category : #matchers }
ShNegativeHandler >> beKindOf: aClass [
	^ self handleMatcher: (ShBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
ShNegativeHandler >> respondTo: aSelector [
	^ self handleMatcher: (ShRespondToMatcher expected: aSelector)
]

{ #category : #matchers }
ShNegativeHandler >> include: aValue [
	^ self handleMatcher: (ShIncludeMatcher expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> match: aPattern [
	^ self handleMatcher: (ShMatchMatcher expected: aPattern)
]

{ #category : #matchers }
ShNegativeHandler >> raiseError [
	^ self handleMatcher: ShRaiseErrorMatcher new
]

{ #category : #matchers }
ShNegativeHandler >> raiseError: anExceptionClass [
	^ self handleMatcher: (ShRaiseErrorMatcher expected: anExceptionClass)
]

{ #category : #matchers }
ShNegativeHandler >> beGreaterThan: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #> expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> beLessThan: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #< expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> beGreaterThanOrEqualTo: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #>= expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> beLessThanOrEqualTo: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #<= expected: aValue)
]

{ #category : #matchers }
ShNegativeHandler >> beTruthy [
	^ self handleMatcher: ShBeMatcher forTruthy
]

{ #category : #matchers }
ShNegativeHandler >> beFalsy [
	^ self handleMatcher: ShBeMatcher forFalsy
]

{ #category : #matchers }
ShNegativeHandler >> beNil [
	^ self handleMatcher: ShBeMatcher forNil
]

{ #category : #matchers }
ShNegativeHandler >> beTrue [
	^ self handleMatcher: (ShEqualMatcher expected: true)
]

{ #category : #matchers }
ShNegativeHandler >> beFalse [
	^ self handleMatcher: (ShEqualMatcher expected: false)
]

{ #category : #matchers }
ShNegativeHandler >> change: aBlock [
	^ ShChangeMatcher new
		actual: actual;
		receiver: aBlock;
		handler: self;
		negate;
		yourself
]
