"Memoized helper definitions (let)"

Namespace current: ShellStone [

Object subclass: LetDefinition [
  | name block value evaluated |

  LetDefinition class >> name: aSymbol block: aBlock [
    ^self new
      name: aSymbol;
      block: aBlock;
      yourself
  ]

  LetDefinition class >> new [
    ^super new initialize
  ]

  initialize [
    evaluated := false.
  ]

  name [ ^name ]
  name: aSymbol [ name := aSymbol ]
  block [ ^block ]
  block: aBlock [ block := aBlock ]

  value [
    "Memoize the value - only evaluate once per example"
    evaluated ifFalse: [
      value := block value.
      evaluated := true.
    ].
    ^value
  ]

  reset [
    "Reset for next example"
    evaluated := false.
    value := nil.
  ]

  evaluated [ ^evaluated ]
]

"Container for let definitions within an example context"
Object subclass: LetContainer [
  | definitions |

  LetContainer class >> new [
    ^super new initialize
  ]

  initialize [
    definitions := Dictionary new.
  ]

  define: aSymbol as: aBlock [
    definitions at: aSymbol put: (LetDefinition name: aSymbol block: aBlock).
  ]

  get: aSymbol [
    ^(definitions at: aSymbol ifAbsent: [
      self error: 'No let definition for: ', aSymbol printString
    ]) value
  ]

  has: aSymbol [
    ^definitions includesKey: aSymbol
  ]

  reset [
    "Reset all definitions for next example"
    definitions do: [:def | def reset].
  ]

  merge: aLetContainer [
    "Merge definitions from parent"
    aLetContainer definitions keysAndValuesDo: [:k :v |
      (definitions includesKey: k) ifFalse: [
        definitions at: k put: (LetDefinition name: k block: v block)
      ]
    ].
  ]

  definitions [ ^definitions ]
]

]
