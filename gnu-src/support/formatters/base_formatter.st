"Abstract base formatter"

Namespace current: ShellStone [

Object subclass: BaseFormatter [
  | output colorOutput |

  BaseFormatter class >> new [
    ^super new initialize
  ]

  BaseFormatter class >> output: aStream [
    ^self new output: aStream; yourself
  ]

  initialize [
    output := Transcript.
    colorOutput := ColorOutput new.
  ]

  output [ ^output ]
  output: aStream [
    output := aStream.
    colorOutput stream: aStream.
  ]

  colorOutput [ ^colorOutput ]
  colorOutput: aColorOutput [ colorOutput := aColorOutput ]

  disableColor [
    colorOutput enabled: false.
  ]

  "Hooks for subclasses to override"
  started [ ]
  finished: results [ ]
  groupStarted: aGroup [ ]
  groupFinished: aGroup [ ]
  exampleStarted: anExample [ ]
  examplePassed: aResult [ ]
  exampleFailed: aResult [ ]
  examplePending: aResult [ ]

  "Common output helpers"
  print: aString [
    output nextPutAll: aString.
  ]

  printLn: aString [
    output nextPutAll: aString; nl.
  ]

  printLn [
    output nl.
  ]
]

]
