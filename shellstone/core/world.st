"Example group registry (World)"

Namespace current: ShellStone [

Object subclass: World [
  | groups currentGroup |

  "Singleton instance"
  World class [
    | instance |
  ]

  World class >> instance [
    instance isNil ifTrue: [ instance := self new ].
    ^instance
  ]

  World class >> reset [
    instance := nil.
  ]

  World class >> new [
    ^super new initialize
  ]

  initialize [
    groups := OrderedCollection new.
    currentGroup := nil.
  ]

  groups [ ^groups ]
  currentGroup [ ^currentGroup ]
  currentGroup: aGroup [ currentGroup := aGroup ]

  register: aGroup [
    groups add: aGroup.
  ]

  clear [
    groups := OrderedCollection new.
    currentGroup := nil.
  ]

  "Collect all examples from all groups"
  allExamples [
    | all |
    all := OrderedCollection new.
    groups do: [:group |
      all addAll: group allExamples.
    ].
    ^all
  ]

  "Filter examples by tag"
  examplesWithTag: aSymbol [
    ^self allExamples select: [:ex | ex hasTag: aSymbol]
  ]

  "Filter examples by pattern"
  examplesMatching: aPattern [
    ^self allExamples select: [:ex |
      ex fullDescription matchRegex: aPattern
    ]
  ]

  "Run all registered groups"
  runAll [
    | results |
    results := OrderedCollection new.
    groups do: [:group |
      results addAll: group run.
    ].
    ^results
  ]

  "Summary statistics"
  exampleCount [
    ^self allExamples size
  ]
]

]
