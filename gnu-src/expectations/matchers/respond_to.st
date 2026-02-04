"RespondTo matcher - check if object responds to a method"

Namespace current: ShellStone [

BaseMatcher subclass: RespondToMatcher [

  RespondToMatcher class >> expected: aSelector [
    ^self new expected: aSelector; yourself
  ]

  matches: actualValue [
    ^actualValue respondsTo: expected
  ]

  positiveFailureMessage [
    ^'expected ', actual printString, ' to respond to #', expected asString
  ]

  negativeFailureMessage [
    ^'expected ', actual printString, ' not to respond to #', expected asString
  ]

  description [
    ^'respond to #', expected asString
  ]
]

]
