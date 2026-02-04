"Message expectation for should_receive"

Namespace current: ShellStone [

Object subclass: MessageExpectation [
  | double selector expectedArgs returnValue expectedCount receivedCalls |

  MessageExpectation class >> new [
    ^super new initialize
  ]

  initialize [
    expectedArgs := nil.
    returnValue := nil.
    expectedCount := nil.  "nil means at least once"
    receivedCalls := OrderedCollection new.
  ]

  double [ ^double ]
  double: aDouble [ double := aDouble ]
  selector [ ^selector ]
  selector: aSymbol [ selector := aSymbol ]
  expectedArgs [ ^expectedArgs ]
  expectedArgs: anArray [ expectedArgs := anArray ]
  returnValue [ ^returnValue ]
  returnValue: aValue [ returnValue := aValue ]
  expectedCount [ ^expectedCount ]
  receivedCalls [ ^receivedCalls ]

  "Chainable configuration"
  withArgs: anArray [
    expectedArgs := anArray.
    ^self
  ]

  withNoArgs [
    expectedArgs := #().
    ^self
  ]

  andReturn: aValue [
    returnValue := aValue.
    ^self
  ]

  once [
    expectedCount := 1.
    ^self
  ]

  twice [
    expectedCount := 2.
    ^self
  ]

  times: aCount [
    expectedCount := aCount.
    ^self
  ]

  never [
    expectedCount := 0.
    ^self
  ]

  atLeastOnce [
    expectedCount := nil.  "default behavior"
    ^self
  ]

  "Record a call"
  recordCall: args [
    receivedCalls add: args.
  ]

  "Verification"
  verify [
    | actualCount |
    actualCount := receivedCalls size.

    "Check count"
    expectedCount isNil ifTrue: [
      "At least once"
      actualCount < 1 ifTrue: [
        (ExpectationFailed new)
          messageText: 'Expected ', double name, ' to receive #', selector asString, ' at least once, but received it ', actualCount printString, ' times';
          signal.
      ].
    ] ifFalse: [
      actualCount ~= expectedCount ifTrue: [
        (ExpectationFailed new)
          messageText: 'Expected ', double name, ' to receive #', selector asString, ' ', expectedCount printString, ' time(s), but received it ', actualCount printString, ' time(s)';
          signal.
      ].
    ].

    "Check args if specified"
    (expectedArgs notNil and: [receivedCalls notEmpty]) ifTrue: [
      (receivedCalls anySatisfy: [:args | args = expectedArgs]) ifFalse: [
        (ExpectationFailed new)
          messageText: 'Expected ', double name, ' to receive #', selector asString, ' with ', expectedArgs printString;
          signal.
      ].
    ].
  ]

  matched [
    "Check if expectation was satisfied (for partial verification)"
    | actualCount |
    actualCount := receivedCalls size.

    expectedCount isNil ifTrue: [
      actualCount < 1 ifTrue: [ ^false ].
    ] ifFalse: [
      actualCount ~= expectedCount ifTrue: [ ^false ].
    ].

    (expectedArgs notNil and: [receivedCalls notEmpty]) ifTrue: [
      (receivedCalls anySatisfy: [:args | args = expectedArgs]) ifFalse: [ ^false ].
    ].

    ^true
  ]
]

]
