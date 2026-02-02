"Progress formatter - dots output (default)"

Namespace current: ShellStone [

BaseFormatter subclass: ProgressFormatter [
  | failures pendingExamples startTime |

  initialize [
    super initialize.
    failures := OrderedCollection new.
    pendingExamples := OrderedCollection new.
  ]

  started [
    startTime := Time millisecondClockValue.
    self printLn.
  ]

  examplePassed: aResult [
    self print: (colorOutput green: '.').
  ]

  exampleFailed: aResult [
    failures add: aResult.
    self print: (colorOutput red: 'F').
  ]

  examplePending: aResult [
    pendingExamples add: aResult.
    self print: (colorOutput yellow: '*').
  ]

  finished: results [
    | elapsed passedCount failedCount pendingCount |
    self printLn.
    self printLn.

    "Print failures"
    failures isEmpty ifFalse: [
      self printLn: 'Failures:'.
      self printLn.
      failures doWithIndex: [:result :index |
        self printFailure: result index: index.
      ].
    ].

    "Print pending"
    pendingExamples isEmpty ifFalse: [
      self printLn: 'Pending:'.
      pendingExamples do: [:result |
        self printLn: '  ', (colorOutput yellow: result fullDescription).
      ].
      self printLn.
    ].

    "Calculate statistics"
    elapsed := (Time millisecondClockValue - startTime) asFloat / 1000.0.
    passedCount := results count: [:r | r passed].
    failedCount := results count: [:r | r failed].
    pendingCount := results count: [:r | r pending].

    "Print summary"
    self printLn: ('Finished in ', (elapsed roundTo: 0.01) printString, ' seconds').
    self printSummary: results size passed: passedCount failed: failedCount pending: pendingCount.
  ]

  printFailure: aResult index: anIndex [
    self printLn: '  ', anIndex printString, ') ', aResult fullDescription.
    self printLn: (colorOutput red: '     ', aResult failureMessage).
    aResult location isEmpty ifFalse: [
      self printLn: (colorOutput cyan: '     # ', aResult location).
    ].
    self printLn.
  ]

  printSummary: total passed: passed failed: failed pending: pending [
    | summary |
    summary := total printString, ' examples, ', failed printString, ' failures'.
    pending > 0 ifTrue: [
      summary := summary, ', ', pending printString, ' pending'.
    ].
    failed > 0
      ifTrue: [ self printLn: (colorOutput red: summary) ]
      ifFalse: [
        pending > 0
          ifTrue: [ self printLn: (colorOutput yellow: summary) ]
          ifFalse: [ self printLn: (colorOutput green: summary) ]
      ].
  ]
]

]
