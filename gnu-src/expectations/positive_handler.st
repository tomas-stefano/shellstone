"Positive expectation handler - handles 'should' assertions"

Namespace current: ShellStone [

Object subclass: PositiveHandler [
  | actual |

  PositiveHandler class >> for: aValue [
    ^self new actual: aValue; yourself
  ]

  actual [ ^actual ]
  actual: aValue [ actual := aValue ]

  "Core method to handle matcher evaluation"
  handleMatcher: aMatcher [
    | result |
    result := aMatcher matchesWithNegation: actual.
    result ifFalse: [
      (ExpectationFailed
        expected: aMatcher expected
        actual: actual
        matcher: aMatcher) signal
    ].
    ^true
  ]

  "Equal matcher"
  equal: expectedValue [
    ^self handleMatcher: (EqualMatcher expected: expectedValue)
  ]

  "Be matcher (truthy/falsy/nil)"
  be: aValue [
    ^self handleMatcher: (BeMatcher expected: aValue)
  ]

  "BeKindOf matcher"
  beA: aClass [
    ^self handleMatcher: (BeKindOfMatcher expected: aClass)
  ]

  beAn: aClass [
    ^self beA: aClass
  ]

  beKindOf: aClass [
    ^self handleMatcher: (BeKindOfMatcher expected: aClass)
  ]

  "RespondTo matcher"
  respondTo: aSelector [
    ^self handleMatcher: (RespondToMatcher expected: aSelector)
  ]

  "Include matcher"
  include: aValue [
    ^self handleMatcher: (IncludeMatcher expected: aValue)
  ]

  "Match matcher (regex)"
  match: aPattern [
    ^self handleMatcher: (MatchMatcher expected: aPattern)
  ]

  "RaiseError matcher"
  raiseError [
    ^self handleMatcher: RaiseErrorMatcher new
  ]

  raiseError: anExceptionClass [
    ^self handleMatcher: (RaiseErrorMatcher expected: anExceptionClass)
  ]

  "Comparison matchers"
  beGreaterThan: aValue [
    ^self handleMatcher: (ComparisonMatcher operator: #> expected: aValue)
  ]

  beLessThan: aValue [
    ^self handleMatcher: (ComparisonMatcher operator: #< expected: aValue)
  ]

  beGreaterThanOrEqualTo: aValue [
    ^self handleMatcher: (ComparisonMatcher operator: #>= expected: aValue)
  ]

  beLessThanOrEqualTo: aValue [
    ^self handleMatcher: (ComparisonMatcher operator: #<= expected: aValue)
  ]

  "Change matcher"
  change: aBlock [
    ^ChangeMatcher new
      actual: actual;
      receiver: aBlock;
      handler: self;
      yourself
  ]

  "Syntax sugar - be truthy, be falsy, be nil"
  beTruthy [
    ^self handleMatcher: (BeMatcher forTruthy)
  ]

  beFalsy [
    ^self handleMatcher: (BeMatcher forFalsy)
  ]

  beNil [
    ^self handleMatcher: (BeMatcher forNil)
  ]

  beTrue [
    ^self handleMatcher: (EqualMatcher expected: true)
  ]

  beFalse [
    ^self handleMatcher: (EqualMatcher expected: false)
  ]
]

]
