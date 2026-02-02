"Documentation formatter - nested descriptions"

Namespace current: ShellStone [

BaseFormatter subclass: DocumentationFormatter [
  | failures pendingExamples startTime currentDepth lastGroup |

  initialize [
    super initialize.
    failures := OrderedCollection new.
    pendingExamples := OrderedCollection new.
    currentDepth := 0.
    lastGroup := nil.
  ]

  started [
    startTime := Time millisecondClockValue.
    self printLn.
  ]

  groupStarted: aGroup [
    | indent parts |
    "Print group descriptions from root if not already printed"
    parts := aGroup descriptionParts.
    indent := ''.
    parts doWithIndex: [:desc :idx |
      idx <= currentDepth ifFalse: [
        self printLn: indent, desc.
      ].
      indent := indent, '  '.
    ].
    currentDepth := parts size.
    lastGroup := aGroup.
  ]

  groupFinished: aGroup [
    aGroup parent isNil ifTrue: [
      currentDepth := 0.
      lastGroup := nil.
    ] ifFalse: [
      currentDepth := aGroup parent descriptionParts size.
      lastGroup := aGroup parent.
    ].
  ]

  examplePassed: aResult [
    | indent |
    self ensureGroupPrinted: aResult example group.
    indent := self indentFor: aResult example.
    self printLn: indent, (colorOutput green: aResult example description).
  ]

  exampleFailed: aResult [
    | indent |
    failures add: aResult.
    self ensureGroupPrinted: aResult example group.
    indent := self indentFor: aResult example.
    self printLn: indent, (colorOutput red: aResult example description, ' (FAILED - ', failures size printString, ')').
  ]

  examplePending: aResult [
    | indent |
    pendingExamples add: aResult.
    self ensureGroupPrinted: aResult example group.
    indent := self indentFor: aResult example.
    self printLn: indent, (colorOutput yellow: aResult example description, ' (PENDING)').
  ]

  ensureGroupPrinted: aGroup [
    lastGroup == aGroup ifFalse: [
      self groupStarted: aGroup.
    ].
  ]

  indentFor: anExample [
    | depth |
    depth := anExample group isNil ifTrue: [0] ifFalse: [anExample group descriptionParts size].
    ^String new: (depth * 2) withAll: Character space
  ]

  finished: results [
    | elapsed passedCount failedCount pendingCount |
    self printLn.

    "Print failures"
    failures isEmpty ifFalse: [
      self printLn.
      self printLn: 'Failures:'.
      self printLn.
      failures doWithIndex: [:result :index |
        self printFailure: result index: index.
      ].
    ].

    "Calculate statistics"
    elapsed := (Time millisecondClockValue - startTime) asFloat / 1000.0.
    passedCount := results count: [:r | r passed].
    failedCount := results count: [:r | r failed].
    pendingCount := results count: [:r | r pending].

    "Print summary"
    self printLn.
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
