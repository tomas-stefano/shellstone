"Filter manager - tag/pattern/line filtering"

Namespace current: ShellStone [

Object subclass: FilterManager [
  | tagFilters patternFilters lineFilters excludeTags |

  FilterManager class >> new [
    ^super new initialize
  ]

  initialize [
    tagFilters := Set new.
    patternFilters := OrderedCollection new.
    lineFilters := Dictionary new. "fileName -> Set of line numbers"
    excludeTags := Set new.
  ]

  "Add filters"
  addTag: aSymbol [
    tagFilters add: aSymbol.
  ]

  addPattern: aString [
    patternFilters add: aString.
  ]

  addLineFilter: aFileName line: aLineNumber [
    | lines |
    lines := lineFilters at: aFileName ifAbsentPut: [Set new].
    lines add: aLineNumber.
  ]

  excludeTag: aSymbol [
    excludeTags add: aSymbol.
  ]

  "Check if example should run"
  shouldRun: anExample [
    "If no filters, run everything"
    self hasFilters ifFalse: [ ^true ].

    "Check exclusions first"
    excludeTags do: [:tag |
      (anExample hasTag: tag) ifTrue: [ ^false ].
    ].

    "If we have filters, example must match at least one"
    tagFilters isEmpty ifFalse: [
      (tagFilters anySatisfy: [:tag | anExample hasTag: tag]) ifFalse: [ ^false ].
    ].

    patternFilters isEmpty ifFalse: [
      (patternFilters anySatisfy: [:pattern |
        anExample fullDescription matchRegex: pattern
      ]) ifFalse: [ ^false ].
    ].

    lineFilters isEmpty ifFalse: [
      | exampleFile exampleLine |
      exampleFile := anExample metadata fileName.
      exampleLine := anExample metadata lineNumber.
      (exampleFile isNil or: [exampleLine isNil]) ifTrue: [ ^false ].
      (lineFilters at: exampleFile ifAbsent: [nil]) isNil ifTrue: [ ^false ].
      ((lineFilters at: exampleFile) includes: exampleLine) ifFalse: [ ^false ].
    ].

    ^true
  ]

  hasFilters [
    ^tagFilters notEmpty or: [
      patternFilters notEmpty or: [
        lineFilters notEmpty
      ]
    ]
  ]

  "Parse filter string like 'spec/foo_spec.st:10'"
  parseLineFilter: aString [
    | parts fileName lineNumber |
    (aString includes: $:) ifFalse: [ ^nil ].
    parts := aString subStrings: ':'.
    parts size >= 2 ifFalse: [ ^nil ].
    fileName := parts first.
    lineNumber := parts second asInteger.
    lineNumber isNil ifTrue: [ ^nil ].
    self addLineFilter: fileName line: lineNumber.
    ^true
  ]

  "Filter a collection of examples"
  filter: examples [
    ^examples select: [:ex | self shouldRun: ex]
  ]

  clear [
    tagFilters := Set new.
    patternFilters := OrderedCollection new.
    lineFilters := Dictionary new.
    excludeTags := Set new.
  ]
]

]
