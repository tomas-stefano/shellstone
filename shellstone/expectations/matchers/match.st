"Match matcher - regex pattern matching"

Namespace current: ShellStone [

BaseMatcher subclass: MatchMatcher [

  MatchMatcher class >> expected: aPattern [
    ^self new expected: aPattern; yourself
  ]

  matches: actualValue [
    | regex |
    expected isString
      ifTrue: [ regex := expected asRegex ]
      ifFalse: [ regex := expected ].
    ^regex search: actualValue asString
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
