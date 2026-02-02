"Reporter - result aggregation and formatter coordination"

Namespace current: ShellStone [

Object subclass: Reporter [
  | formatters results profiler |

  Reporter class >> new [
    ^super new initialize
  ]

  Reporter class >> withFormatter: aFormatter [
    ^self new addFormatter: aFormatter; yourself
  ]

  initialize [
    formatters := OrderedCollection new.
    results := OrderedCollection new.
    profiler := Profiler new.
  ]

  formatters [ ^formatters ]
  results [ ^results ]
  profiler [ ^profiler ]
  profiler: aProfiler [ profiler := aProfiler ]

  addFormatter: aFormatter [
    formatters add: aFormatter.
  ]

  "Notify all formatters"
  started [
    formatters do: [:f | f started].
  ]

  finished [
    formatters do: [:f | f finished: results].
  ]

  groupStarted: aGroup [
    formatters do: [:f | f groupStarted: aGroup].
  ]

  groupFinished: aGroup [
    formatters do: [:f | f groupFinished: aGroup].
  ]

  exampleStarted: anExample [
    formatters do: [:f | f exampleStarted: anExample].
  ]

  exampleFinished: aResult [
    results add: aResult.
    profiler recordResult: aResult.

    aResult passed ifTrue: [
      formatters do: [:f | f examplePassed: aResult].
    ].
    aResult failed ifTrue: [
      formatters do: [:f | f exampleFailed: aResult].
    ].
    aResult pending ifTrue: [
      formatters do: [:f | f examplePending: aResult].
    ].
  ]

  "Statistics"
  passedCount [
    ^results count: [:r | r passed]
  ]

  failedCount [
    ^results count: [:r | r failed]
  ]

  pendingCount [
    ^results count: [:r | r pending]
  ]

  totalCount [
    ^results size
  ]

  hasFailures [
    ^self failedCount > 0
  ]

  allPassed [
    ^self hasFailures not
  ]
]

]
