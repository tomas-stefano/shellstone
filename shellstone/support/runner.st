"Main test runner - wires everything together"

Namespace current: ShellStone [

Object subclass: Runner [
  | options reporter filterManager ordering profiler outputStream specFiles |

  Runner class [
    | loadPath specHelperPath |
  ]

  Runner class >> new [
    ^super new initialize
  ]

  Runner class >> loadPath [
    ^loadPath ifNil: ['']
  ]

  Runner class >> loadPath: aPath [
    loadPath := aPath.
  ]

  Runner class >> specHelperPath [
    ^specHelperPath ifNil: ['spec/spec_helper.st']
  ]

  Runner class >> specHelperPath: aPath [
    specHelperPath := aPath.
  ]

  initialize [
    options := OptionsParser new.
    reporter := Reporter new.
    filterManager := FilterManager new.
    ordering := Ordering defined.
    profiler := Profiler new.
    specFiles := OrderedCollection new.
  ]

  options [ ^options ]
  reporter [ ^reporter ]

  start [
    "Main entry point"
    self parseOptions.
    self setupOutputStream.
    self setupFormatter.
    self setupFiltering.
    self setupOrdering.
    self setupProfiler.

    self loadSpecHelper.
    self loadFilesFromLoadPath.
    self findSpecFiles.
    self loadSpecFiles.

    options dryRun
      ifTrue: [ self dryRun ]
      ifFalse: [ self run ].
  ]

  parseOptions [
    options parse.
  ]

  setupOutputStream [
    options outputFile isNil
      ifTrue: [ outputStream := Transcript ]
      ifFalse: [ outputStream := FileStream open: options outputFile mode: FileStream write ].
  ]

  setupFormatter [
    | formatter |
    formatter := options buildFormatter.
    formatter output: outputStream.
    options noColor ifTrue: [ formatter disableColor ].
    reporter addFormatter: formatter.
  ]

  setupFiltering [
    filterManager := options buildFilterManager.
  ]

  setupOrdering [
    ordering := options buildOrdering.
  ]

  setupProfiler [
    profiler := options buildProfiler.
    reporter profiler: profiler.
  ]

  loadSpecHelper [
    | helperPath file |
    helperPath := self class specHelperPath.
    file := File name: helperPath.
    file exists ifTrue: [
      FileStream fileIn: helperPath.
    ].
  ]

  loadFilesFromLoadPath [
    | loadPath pattern |
    loadPath := self class loadPath.
    loadPath isEmpty ifTrue: [ ^self ].

    pattern := loadPath, '/**/*.st'.
    Directory working allFilesMatching: pattern do: [:file |
      FileStream fileIn: file asString.
    ].
  ]

  findSpecFiles [
    | searchPaths |
    searchPaths := options files isEmpty
      ifTrue: [ OrderedCollection with: 'spec' ]
      ifFalse: [ options files ].

    searchPaths do: [:path |
      | file |
      file := File name: path.
      (file exists and: [file isDirectory])
        ifTrue: [ self findSpecFilesIn: path ]
        ifFalse: [
          (path endsWith: '_spec.st') ifTrue: [
            specFiles add: path.
          ].
        ].
    ].
  ]

  findSpecFilesIn: aDirectory [
    | pattern dir |
    "Remove trailing slash if present"
    dir := aDirectory.
    (dir endsWith: '/') ifTrue: [
      dir := dir copyFrom: 1 to: dir size - 1.
    ].
    pattern := dir, '/**/*_spec.st'.
    Directory working allFilesMatching: pattern do: [:file |
      specFiles add: file asString.
    ].
  ]

  loadSpecFiles [
    specFiles do: [:specFile |
      FileStream fileIn: specFile.
    ].
  ]

  dryRun [
    "List examples without running"
    | examples |
    examples := World instance allExamples.
    examples := filterManager filter: examples.
    examples := ordering order: examples.

    Transcript show: 'Would run ', examples size printString, ' examples:'; cr; cr.
    examples do: [:example |
      Transcript show: '  ', example fullDescription; cr.
    ].
  ]

  run [
    | examples results |
    examples := World instance allExamples.
    examples := filterManager filter: examples.
    examples := ordering order: examples.

    reporter started.

    examples do: [:example |
      | result |
      reporter exampleStarted: example.
      result := self runExample: example.
      result startTime: Time millisecondClockValue.
      reporter exampleFinished: result.
      result endTime: Time millisecondClockValue.

      "Fail fast check"
      (options failFast and: [result failed]) ifTrue: [
        reporter finished.
        self exit: 1.
      ].
    ].

    reporter finished.

    "Print profile report if enabled"
    profiler enabled ifTrue: [
      Transcript nextPutAll: (profiler report: (reporter formatters first colorOutput)).
    ].

    "Exit with appropriate code"
    reporter hasFailures
      ifTrue: [ self exit: 1 ]
      ifFalse: [ self exit: 0 ].
  ]

  runExample: anExample [
    | group effectiveHooks effectiveLets |
    group := anExample group.
    group isNil ifTrue: [
      ^anExample run
    ].
    effectiveHooks := group effectiveHooks.
    effectiveLets := group effectiveLets.
    ^anExample runWithHooks: effectiveHooks lets: effectiveLets
  ]

  exit: aCode [
    outputStream ~~ Transcript ifTrue: [
      outputStream close.
    ].
    ObjectMemory quit: aCode.
  ]
]

]
