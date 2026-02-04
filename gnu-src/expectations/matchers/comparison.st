"Comparison matchers - >, <, >=, <="

Namespace current: ShellStone [

BaseMatcher subclass: ComparisonMatcher [
  | operator |

  ComparisonMatcher class >> operator: aSymbol expected: aValue [
    ^self new
      operator: aSymbol;
      expected: aValue;
      yourself
  ]

  operator [ ^operator ]
  operator: aSymbol [ operator := aSymbol ]

  matches: actualValue [
    operator = #> ifTrue: [ ^actualValue > expected ].
    operator = #< ifTrue: [ ^actualValue < expected ].
    operator = #>= ifTrue: [ ^actualValue >= expected ].
    operator = #<= ifTrue: [ ^actualValue <= expected ].
    ^false
  ]

  operatorDescription [
    operator = #> ifTrue: [ ^'greater than' ].
    operator = #< ifTrue: [ ^'less than' ].
    operator = #>= ifTrue: [ ^'greater than or equal to' ].
    operator = #<= ifTrue: [ ^'less than or equal to' ].
    ^'compare to'
  ]

  positiveFailureMessage [
    ^'expected ', actual printString, ' to be ', self operatorDescription, ' ', expected printString
  ]

  negativeFailureMessage [
    ^'expected ', actual printString, ' not to be ', self operatorDescription, ' ', expected printString
  ]

  description [
    ^'be ', self operatorDescription, ' ', expected printString
  ]
]

]
