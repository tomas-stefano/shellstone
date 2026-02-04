"ANSI color output support for ShellStone"

Namespace current: ShellStone [

Object subclass: ColorOutput [
  | enabled stream |

  "ANSI color codes"
  ColorOutput class >> reset [ ^Character esc asString, '[0m' ]
  ColorOutput class >> red [ ^Character esc asString, '[31m' ]
  ColorOutput class >> green [ ^Character esc asString, '[32m' ]
  ColorOutput class >> yellow [ ^Character esc asString, '[33m' ]
  ColorOutput class >> blue [ ^Character esc asString, '[34m' ]
  ColorOutput class >> magenta [ ^Character esc asString, '[35m' ]
  ColorOutput class >> cyan [ ^Character esc asString, '[36m' ]
  ColorOutput class >> white [ ^Character esc asString, '[37m' ]
  ColorOutput class >> bold [ ^Character esc asString, '[1m' ]
  ColorOutput class >> dim [ ^Character esc asString, '[2m' ]

  ColorOutput class >> new [
    ^super new initialize
  ]

  initialize [
    enabled := true.
    stream := Transcript.
  ]

  enabled [ ^enabled ]
  enabled: aBoolean [ enabled := aBoolean ]
  stream [ ^stream ]
  stream: aStream [ stream := aStream ]

  wrap: aString with: colorCode [
    enabled ifFalse: [ ^aString ].
    ^colorCode, aString, self class reset
  ]

  red: aString [ ^self wrap: aString with: self class red ]
  green: aString [ ^self wrap: aString with: self class green ]
  yellow: aString [ ^self wrap: aString with: self class yellow ]
  blue: aString [ ^self wrap: aString with: self class blue ]
  magenta: aString [ ^self wrap: aString with: self class magenta ]
  cyan: aString [ ^self wrap: aString with: self class cyan ]
  white: aString [ ^self wrap: aString with: self class white ]
  bold: aString [ ^self wrap: aString with: self class bold ]
  dim: aString [ ^self wrap: aString with: self class dim ]

  success: aString [ ^self green: aString ]
  failure: aString [ ^self red: aString ]
  pending: aString [ ^self yellow: aString ]
  detail: aString [ ^self cyan: aString ]

  print: aString [
    stream nextPutAll: aString.
  ]

  printLn: aString [
    stream nextPutAll: aString; nl.
  ]

  printSuccess: aString [ self printLn: (self success: aString) ]
  printFailure: aString [ self printLn: (self failure: aString) ]
  printPending: aString [ self printLn: (self pending: aString) ]
]

]
