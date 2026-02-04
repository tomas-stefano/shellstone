"Include matcher - check if collection includes item(s)"

Namespace current: ShellStone [

BaseMatcher subclass: IncludeMatcher [
  | multipleExpected |

  IncludeMatcher class >> expected: aValue [
    ^self new expected: aValue; yourself
  ]

  IncludeMatcher class >> expectedAll: aCollection [
    ^self new
      expected: aCollection;
      multipleExpected: true;
      yourself
  ]

  multipleExpected [ ^multipleExpected ifNil: [false] ]
  multipleExpected: aBoolean [ multipleExpected := aBoolean ]

  matches: actualValue [
    self multipleExpected ifTrue: [
      ^expected allSatisfy: [:item | self doesActual: actualValue include: item]
    ].
    ^self doesActual: actualValue include: expected
  ]

  doesActual: actualValue include: item [
    "Handle string substring matching differently"
    (actualValue isKindOf: CharacterArray) ifTrue: [
      (item isKindOf: CharacterArray) ifTrue: [
        ^(actualValue indexOfSubCollection: item) > 0
      ].
    ].
    ^actualValue includes: item
  ]

  positiveFailureMessage [
    self multipleExpected ifTrue: [
      | missing |
      missing := expected reject: [:item | actual includes: item].
      ^'expected ', actual printString, ' to include ', missing printString
    ].
    ^'expected ', actual printString, ' to include ', expected printString
  ]

  negativeFailureMessage [
    ^'expected ', actual printString, ' not to include ', expected printString
  ]

  description [
    ^'include ', expected printString
  ]
]

]
