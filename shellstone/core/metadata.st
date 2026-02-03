"Metadata/tagging support for examples and groups"

Namespace current: ShellStone [

Object subclass: Metadata [
  | tags data location lineNumber fileName |

  Metadata class >> new [
    ^super new initialize
  ]

  initialize [
    tags := Set new.
    data := Dictionary new.
  ]

  tags [ ^tags ]
  data [ ^data ]
  location [ ^location ]
  location: aString [ location := aString ]
  lineNumber [ ^lineNumber ]
  lineNumber: anInteger [ lineNumber := anInteger ]
  fileName [ ^fileName ]
  fileName: aString [ fileName := aString ]

  addTag: aSymbol [
    tags add: aSymbol.
  ]

  addTags: aCollection [
    aCollection do: [:tag | self addTag: tag].
  ]

  hasTag: aSymbol [
    ^tags includes: aSymbol
  ]

  hasAnyTag: aCollection [
    ^aCollection anySatisfy: [:tag | self hasTag: tag]
  ]

  at: aKey [
    ^data at: aKey ifAbsent: [nil]
  ]

  at: aKey put: aValue [
    data at: aKey put: aValue.
  ]

  merge: aMetadata [
    aMetadata tags do: [:tag | self addTag: tag].
    aMetadata data keysAndValuesDo: [:k :v | self at: k put: v].
  ]

  fullLocation [
    fileName isNil ifTrue: [ ^'' ].
    lineNumber isNil ifTrue: [ ^fileName ].
    ^fileName, ':', lineNumber printString
  ]
]

]
