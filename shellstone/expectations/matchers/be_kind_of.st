"BeKindOf matcher - type checking"

Namespace current: ShellStone [

BaseMatcher subclass: BeKindOfMatcher [

  BeKindOfMatcher class >> expected: aClass [
    ^self new expected: aClass; yourself
  ]

  matches: actualValue [
    ^actualValue isKindOf: expected
  ]

  positiveFailureMessage [
    ^'expected ', actual printString, ' to be a kind of ', expected name, ' but was ', actual class name
  ]

  negativeFailureMessage [
    ^'expected ', actual printString, ' not to be a kind of ', expected name
  ]

  description [
    ^'be a kind of ', expected name
  ]
]

]
