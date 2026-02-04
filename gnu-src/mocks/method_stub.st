"Method stub for doubles"

Namespace current: ShellStone [

Object subclass: MethodStub [
  | double selector returnValue block exception callCount |

  MethodStub class >> new [
    ^super new initialize
  ]

  initialize [
    callCount := 0.
  ]

  double [ ^double ]
  double: aDouble [ double := aDouble ]
  selector [ ^selector ]
  selector: aSymbol [ selector := aSymbol ]
  returnValue [ ^returnValue ]
  returnValue: aValue [ returnValue := aValue ]
  block [ ^block ]
  block: aBlock [ block := aBlock ]
  exception [ ^exception ]
  exception: anException [ exception := anException ]
  callCount [ ^callCount ]

  "Chainable methods"
  andReturn: aValue [
    returnValue := aValue.
    ^self
  ]

  andDo: aBlock [
    block := aBlock.
    ^self
  ]

  andRaise: anException [
    exception := anException.
    ^self
  ]

  "Execute the stub"
  valueWithArgs: anArray [
    callCount := callCount + 1.

    exception notNil ifTrue: [
      exception signal.
    ].

    block notNil ifTrue: [
      ^block valueWithArguments: anArray
    ].

    ^returnValue
  ]

  value [
    ^self valueWithArgs: #()
  ]
]

]
