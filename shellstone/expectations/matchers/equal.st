"Equal matcher - checks if actual equals expected"

Namespace current: ShellStone [

BaseMatcher subclass: EqualMatcher [

  EqualMatcher class >> expected: aValue [
    ^self new expected: aValue; yourself
  ]

  matches: actualValue [
    ^actualValue = expected
  ]

  positiveFailureMessage [
    ^'expected ', expected printString, ' but got ', actual printString
  ]

  negativeFailureMessage [
    ^'expected value to not equal ', expected printString
  ]

  description [
    ^'equal ', expected printString
  ]
]

]
