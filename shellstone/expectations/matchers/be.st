"Be matcher - truthy/falsy/nil checks"

Namespace current: ShellStone [

BaseMatcher subclass: BeMatcher [
  | mode |

  "Modes: #truthy, #falsy, #nil, #value"
  BeMatcher class >> expected: aValue [
    ^self new mode: #value; expected: aValue; yourself
  ]

  BeMatcher class >> forTruthy [
    ^self new mode: #truthy; yourself
  ]

  BeMatcher class >> forFalsy [
    ^self new mode: #falsy; yourself
  ]

  BeMatcher class >> forNil [
    ^self new mode: #nil; yourself
  ]

  mode [ ^mode ]
  mode: aSymbol [ mode := aSymbol ]

  matches: actualValue [
    mode = #truthy ifTrue: [
      ^actualValue notNil and: [actualValue ~= false]
    ].
    mode = #falsy ifTrue: [
      ^actualValue isNil or: [actualValue = false]
    ].
    mode = #nil ifTrue: [
      ^actualValue isNil
    ].
    "Mode is #value - compare identity"
    ^actualValue == expected
  ]

  positiveFailureMessage [
    mode = #truthy ifTrue: [
      ^'expected ', actual printString, ' to be truthy'
    ].
    mode = #falsy ifTrue: [
      ^'expected ', actual printString, ' to be falsy'
    ].
    mode = #nil ifTrue: [
      ^'expected ', actual printString, ' to be nil'
    ].
    ^'expected ', expected printString, ' but got ', actual printString
  ]

  negativeFailureMessage [
    mode = #truthy ifTrue: [
      ^'expected ', actual printString, ' not to be truthy'
    ].
    mode = #falsy ifTrue: [
      ^'expected ', actual printString, ' not to be falsy'
    ].
    mode = #nil ifTrue: [
      ^'expected ', actual printString, ' not to be nil'
    ].
    ^'expected value not to be ', expected printString
  ]

  description [
    mode = #truthy ifTrue: [ ^'be truthy' ].
    mode = #falsy ifTrue: [ ^'be falsy' ].
    mode = #nil ifTrue: [ ^'be nil' ].
    ^'be ', expected printString
  ]
]

]
