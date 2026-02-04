"Positive expectation handler - handles 'should' assertions"
Class {
	#name : #ShPositiveHandler,
	#superclass : #Object,
	#instVars : [
		'actual'
	],
	#category : #'ShellStone-Expectations'
}

{ #category : #'instance creation' }
ShPositiveHandler class >> for: aValue [
	^ self new actual: aValue; yourself
]

{ #category : #accessing }
ShPositiveHandler >> actual [
	^ actual
]

{ #category : #accessing }
ShPositiveHandler >> actual: aValue [
	actual := aValue
]

{ #category : #handling }
ShPositiveHandler >> handleMatcher: aMatcher [
	"Core method to handle matcher evaluation"
	| result |
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
ShPositiveHandler >> equal: expectedValue [
	^ self handleMatcher: (ShEqualMatcher expected: expectedValue)
]

{ #category : #matchers }
ShPositiveHandler >> be: aValue [
	^ self handleMatcher: (ShBeMatcher expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> beA: aClass [
	^ self handleMatcher: (ShBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
ShPositiveHandler >> beAn: aClass [
	^ self beA: aClass
]

{ #category : #matchers }
ShPositiveHandler >> beKindOf: aClass [
	^ self handleMatcher: (ShBeKindOfMatcher expected: aClass)
]

{ #category : #matchers }
ShPositiveHandler >> respondTo: aSelector [
	^ self handleMatcher: (ShRespondToMatcher expected: aSelector)
]

{ #category : #matchers }
ShPositiveHandler >> include: aValue [
	^ self handleMatcher: (ShIncludeMatcher expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> match: aPattern [
	^ self handleMatcher: (ShMatchMatcher expected: aPattern)
]

{ #category : #matchers }
ShPositiveHandler >> raiseError [
	^ self handleMatcher: ShRaiseErrorMatcher new
]

{ #category : #matchers }
ShPositiveHandler >> raiseError: anExceptionClass [
	^ self handleMatcher: (ShRaiseErrorMatcher expected: anExceptionClass)
]

{ #category : #matchers }
ShPositiveHandler >> beGreaterThan: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #> expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> beLessThan: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #< expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> beGreaterThanOrEqualTo: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #>= expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> beLessThanOrEqualTo: aValue [
	^ self handleMatcher: (ShComparisonMatcher operator: #<= expected: aValue)
]

{ #category : #matchers }
ShPositiveHandler >> change: aBlock [
	^ ShChangeMatcher new
		actual: actual;
		receiver: aBlock;
		handler: self;
		yourself
]

{ #category : #matchers }
ShPositiveHandler >> beTruthy [
	^ self handleMatcher: ShBeMatcher forTruthy
]

{ #category : #matchers }
ShPositiveHandler >> beFalsy [
	^ self handleMatcher: ShBeMatcher forFalsy
]

{ #category : #matchers }
ShPositiveHandler >> beNil [
	^ self handleMatcher: ShBeMatcher forNil
]

{ #category : #matchers }
ShPositiveHandler >> beTrue [
	^ self handleMatcher: (ShEqualMatcher expected: true)
]

{ #category : #matchers }
ShPositiveHandler >> beFalse [
	^ self handleMatcher: (ShEqualMatcher expected: false)
]
