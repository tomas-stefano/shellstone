"RaiseError matcher - exception testing"

Namespace current: ShellStone [

BaseMatcher subclass: RaiseErrorMatcher [
  | raisedException expectedMessage |

  RaiseErrorMatcher class >> new [
    ^super new
  ]

  RaiseErrorMatcher class >> expected: anExceptionClass [
    ^self new expected: anExceptionClass; yourself
  ]

  RaiseErrorMatcher class >> expected: anExceptionClass message: aString [
    ^self new
      expected: anExceptionClass;
      expectedMessage: aString;
      yourself
  ]

  initialize [
    super initialize.
    expected := Exception.
    raisedException := nil.
  ]

  expectedMessage [ ^expectedMessage ]
  expectedMessage: aString [ expectedMessage := aString ]
  raisedException [ ^raisedException ]

  matches: actualValue [
    "actualValue should be a block"
    [
      actualValue value.
      "No exception raised"
      raisedException := nil.
      ^false
    ] on: Exception do: [:ex |
      raisedException := ex.
      "Check if it's the expected type"
      (ex isKindOf: expected) ifFalse: [ ^false ].
      "Check message if specified"
      expectedMessage isNil ifTrue: [ ^true ].
      ^ex messageText = expectedMessage
    ].
  ]

  positiveFailureMessage [
    raisedException isNil ifTrue: [
      ^'expected block to raise ', expected name, ' but nothing was raised'
    ].
    (raisedException isKindOf: expected) ifFalse: [
      ^'expected block to raise ', expected name, ' but ', raisedException class name, ' was raised'
    ].
    expectedMessage isNil ifFalse: [
      ^'expected exception with message ''', expectedMessage, ''' but got ''', raisedException messageText, ''''
    ].
    ^'expected block to raise ', expected name
  ]

  negativeFailureMessage [
    ^'expected block not to raise ', expected name, ' but it did'
  ]

  description [
    expectedMessage isNil
      ifTrue: [ ^'raise ', expected name ]
      ifFalse: [ ^'raise ', expected name, ' with message ''', expectedMessage, '''' ]
  ]
]

]
