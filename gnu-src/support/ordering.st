"Ordering - example ordering strategies"

Namespace current: ShellStone [

Object subclass: Ordering [
  | strategy seed random |

  "Strategy symbols: #defined, #random"
  Ordering class >> new [
    ^super new initialize
  ]

  Ordering class >> defined [
    ^self new strategy: #defined; yourself
  ]

  Ordering class >> random [
    ^self new strategy: #random; yourself
  ]

  Ordering class >> randomWithSeed: aSeed [
    ^self new
      strategy: #random;
      seed: aSeed;
      yourself
  ]

  initialize [
    strategy := #defined.
    seed := nil.
    random := nil.
  ]

  strategy [ ^strategy ]
  strategy: aSymbol [ strategy := aSymbol ]
  seed [ ^seed ]
  seed: anInteger [
    seed := anInteger.
    random := Random seed: seed.
  ]

  "Order examples"
  order: examples [
    strategy = #defined ifTrue: [ ^examples ].
    strategy = #random ifTrue: [ ^self shuffle: examples ].
    ^examples
  ]

  shuffle: aCollection [
    | result size rand |
    result := aCollection asOrderedCollection copy.
    size := result size.
    rand := random ifNil: [Random new].

    "Fisher-Yates shuffle"
    size to: 2 by: -1 do: [:i |
      | j temp |
      j := (rand nextInt: i).
      temp := result at: i.
      result at: i put: (result at: j).
      result at: j put: temp.
    ].
    ^result
  ]

  "Parse order string like 'random:12345'"
  Ordering class >> parse: aString [
    | parts |
    aString = 'defined' ifTrue: [ ^self defined ].
    aString = 'random' ifTrue: [ ^self random ].
    aString = 'rand' ifTrue: [ ^self random ].

    (aString startsWith: 'random:') ifTrue: [
      parts := aString subStrings: ':'.
      parts size >= 2 ifTrue: [
        ^self randomWithSeed: parts second asInteger
      ].
    ].

    ^self defined
  ]
]

]
