"Match matcher - regex pattern matching"

Namespace current: ShellStone [

BaseMatcher subclass: MatchMatcher [

  MatchMatcher class >> expected: aPattern [
    ^self new expected: aPattern; yourself
  ]

  matches: actualValue [
    "Use simple substring matching for now"
    ^(actualValue asString indexOfSubCollection: expected asString) > 0
  ]

  positiveFailureMessage [
    ^'expected ''', actual asString, ''' to match ''', expected asString, ''''
  ]

  negativeFailureMessage [
    ^'expected ''', actual asString, ''' not to match ''', expected asString, ''''
  ]

  description [
    ^'match ''', expected asString, ''''
  ]
]

]
