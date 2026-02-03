"Abstract base class for all matchers"

Namespace current: ShellStone [

Object subclass: BaseMatcher [
  | actual expected negated |

  BaseMatcher class >> new [
    ^super new initialize
  ]

  initialize [
    negated := false.
  ]

  actual [ ^actual ]
  actual: aValue [ actual := aValue ]
  expected [ ^expected ]
  expected: aValue [ expected := aValue ]
  negated [ ^negated ]
  negated: aBoolean [ negated := aBoolean ]

  "Override in subclasses to perform the match"
  matches: actualValue [
    self subclassResponsibility
  ]

  "Returns true if match passes (considering negation)"
  matchesWithNegation: actualValue [
    | result |
    actual := actualValue.
    result := self matches: actualValue.
    negated ifTrue: [ ^result not ].
    ^result
  ]

  "Override to provide failure message"
  failureMessage [
    negated
      ifTrue: [ ^self negativeFailureMessage ]
      ifFalse: [ ^self positiveFailureMessage ]
  ]

  positiveFailureMessage [
    ^'expected ', expected printString, ' but got ', actual printString
  ]

  negativeFailureMessage [
    ^'expected not ', expected printString, ' but got ', actual printString
  ]

  "Human-readable description of what the matcher expects"
  description [
    ^'match'
  ]

  "Chainable method for negation"
  negate [
    negated := true.
    ^self
  ]
]

]
