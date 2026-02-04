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

  "RSpec 3 style aliases"
  to [ ^self should ]
  toNot [ ^self shouldNot ]
  to_not [ ^self shouldNot ]
  notTo [ ^self shouldNot ]
  not_to [ ^self shouldNot ]
]

]
