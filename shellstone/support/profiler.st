"Profiler - timing of slow examples"

Namespace current: ShellStone [

Object subclass: Profiler [
  | enabled count results |

  Profiler class >> new [
    ^super new initialize
  ]

  Profiler class >> enabled: aCount [
    ^self new
      enabled: true;
      count: aCount;
      yourself
  ]

  initialize [
    enabled := false.
    count := 10.
    results := OrderedCollection new.
  ]

  enabled [ ^enabled ]
  enabled: aBoolean [ enabled := aBoolean ]
  count [ ^count ]
  count: anInteger [ count := anInteger ]
  results [ ^results ]

  recordResult: aResult [
    enabled ifTrue: [
      results add: aResult.
    ].
  ]

  slowestExamples [
    | sorted |
    sorted := results asSortedCollection: [:a :b | a duration > b duration].
    ^sorted copyFrom: 1 to: (count min: sorted size)
  ]

  report: colorOutput [
    | slowest |
    enabled ifFalse: [ ^'' ].
    results isEmpty ifTrue: [ ^'' ].

    slowest := self slowestExamples.
    ^String streamContents: [:stream |
      stream cr.
      stream nextPutAll: 'Top ', count printString, ' slowest examples:'; cr.
      slowest do: [:result |
        stream nextPutAll: '  '.
        stream nextPutAll: (colorOutput cyan: result duration printString, ' seconds').
        stream nextPutAll: ' '.
        stream nextPutAll: result fullDescription.
        stream cr.
      ].
    ]
  ]
]

]
