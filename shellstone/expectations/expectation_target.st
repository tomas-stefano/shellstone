"Wrapper for actual values in expectations"

Namespace current: ShellStone [

Object subclass: ExpectationTarget [
  | actual |

  ExpectationTarget class >> for: aValue [
    ^self new actual: aValue; yourself
  ]

  actual [ ^actual ]
  actual: aValue [ actual := aValue ]

  "Main entry point for positive expectations"
  should [
    ^PositiveHandler for: actual
  ]

  "Main entry point for negative expectations"
  shouldNot [
    ^NegativeHandler for: actual
  ]
]

]
