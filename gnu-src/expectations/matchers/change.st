"Change matcher - test that a block changes a value"

Namespace current: ShellStone [

BaseMatcher subclass: ChangeMatcher [
  | receiver handler valueBefore valueAfter byAmount fromValue toValue |

  ChangeMatcher class >> new [
    ^super new initialize
  ]

  initialize [
    byAmount := nil.
    fromValue := nil.
    toValue := nil.
  ]

  receiver [ ^receiver ]
  receiver: aBlock [ receiver := aBlock ]
  handler [ ^handler ]
  handler: aHandler [ handler := aHandler ]

  "Chainable modifiers"
  by: anAmount [
    byAmount := anAmount.
    ^self verify
  ]

  from: aValue [
    fromValue := aValue.
    ^self
  ]

  to: aValue [
    toValue := aValue.
    ^self verify
  ]

  from: startValue to: endValue [
    fromValue := startValue.
    toValue := endValue.
    ^self verify
  ]

  verify [
    "Execute and verify the change"
    ^handler handleMatcher: self
  ]

  matches: actualBlock [
    "actualBlock is the block being tested (actual)"
    "receiver is the block that produces the value to check"
    valueBefore := receiver value.
    actualBlock value.
    valueAfter := receiver value.

    "Check from value if specified"
    (fromValue notNil and: [valueBefore ~= fromValue]) ifTrue: [ ^false ].

    "Check to value if specified"
    (toValue notNil and: [valueAfter ~= toValue]) ifTrue: [ ^false ].

    "Check by amount if specified"
    byAmount notNil ifTrue: [
      ^(valueAfter - valueBefore) = byAmount
    ].

    "Just check that value changed"
    ^valueBefore ~= valueAfter
  ]

  positiveFailureMessage [
    byAmount notNil ifTrue: [
      ^'expected value to change by ', byAmount printString,
        ' but changed from ', valueBefore printString, ' to ', valueAfter printString,
        ' (difference: ', (valueAfter - valueBefore) printString, ')'
    ].
    (fromValue notNil and: [toValue notNil]) ifTrue: [
      ^'expected value to change from ', fromValue printString, ' to ', toValue printString,
        ' but changed from ', valueBefore printString, ' to ', valueAfter printString
    ].
    fromValue notNil ifTrue: [
      ^'expected value to start at ', fromValue printString, ' but was ', valueBefore printString
    ].
    toValue notNil ifTrue: [
      ^'expected value to change to ', toValue printString, ' but was ', valueAfter printString
    ].
    ^'expected value to change but it stayed ', valueBefore printString
  ]

  negativeFailureMessage [
    ^'expected value not to change but it changed from ', valueBefore printString, ' to ', valueAfter printString
  ]

  description [
    byAmount notNil ifTrue: [
      ^'change by ', byAmount printString
    ].
    (fromValue notNil and: [toValue notNil]) ifTrue: [
      ^'change from ', fromValue printString, ' to ', toValue printString
    ].
    ^'change'
  ]
]

]
