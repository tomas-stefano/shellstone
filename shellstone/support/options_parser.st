"Full CLI options parser"

Namespace current: ShellStone [

Object subclass: OptionsParser [
  | format outputFile order seed failFast examplePattern tags pattern
    profileCount dryRun showVersion showHelp noColor files |

  OptionsParser class >> new [
    ^super new initialize
  ]

  OptionsParser class >> version [
    ^'1.0.0'
  ]

  initialize [
    format := 'progress'.
    outputFile := nil.
    order := 'defined'.
    seed := nil.
    failFast := false.
    examplePattern := nil.
    tags := OrderedCollection new.
    pattern := '**/*_spec.st'.
    profileCount := nil.
    dryRun := false.
    showVersion := false.
    showHelp := false.
    noColor := false.
    files := OrderedCollection new.
  ]

  "Accessors"
  format [ ^format ]
  outputFile [ ^outputFile ]
  order [ ^order ]
  seed [ ^seed ]
  failFast [ ^failFast ]
  examplePattern [ ^examplePattern ]
  tags [ ^tags ]
  pattern [ ^pattern ]
  profileCount [ ^profileCount ]
  dryRun [ ^dryRun ]
  showVersion [ ^showVersion ]
  showHelp [ ^showHelp ]
  noColor [ ^noColor ]
  files [ ^files ]

  parse [
    | args i |
    args := Smalltalk arguments.
    i := 1.

    [i <= args size] whileTrue: [
      | arg |
      arg := args at: i.
      (self parseOption: arg args: args index: i) ifTrue: [
        "Option consumed, may have incremented i"
      ] ifFalse: [
        "Not an option, treat as file"
        files add: arg.
      ].
      i := i + 1.
    ].

    "Handle version/help first"
    showVersion ifTrue: [ self printVersion. ^self ].
    showHelp ifTrue: [ self printHelp. ^self ].

    ^self
  ]

  parseOption: arg args: args index: i [
    "Returns true if arg was an option"

    (arg = '-f' or: [arg = '--format']) ifTrue: [
      i < args size ifTrue: [ format := args at: i + 1 ].
      ^true
    ].

    (arg startsWith: '--format=') ifTrue: [
      format := arg copyFrom: 10 to: arg size.
      ^true
    ].

    (arg = '-o' or: [arg = '--out']) ifTrue: [
      i < args size ifTrue: [ outputFile := args at: i + 1 ].
      ^true
    ].

    (arg startsWith: '--out=') ifTrue: [
      outputFile := arg copyFrom: 7 to: arg size.
      ^true
    ].

    (arg = '--order') ifTrue: [
      i < args size ifTrue: [ order := args at: i + 1 ].
      ^true
    ].

    (arg startsWith: '--order=') ifTrue: [
      order := arg copyFrom: 9 to: arg size.
      ^true
    ].

    (arg = '--seed') ifTrue: [
      i < args size ifTrue: [ seed := (args at: i + 1) asInteger ].
      ^true
    ].

    (arg startsWith: '--seed=') ifTrue: [
      seed := (arg copyFrom: 8 to: arg size) asInteger.
      ^true
    ].

    (arg = '--fail-fast') ifTrue: [
      failFast := true.
      ^true
    ].

    (arg = '-e' or: [arg = '--example']) ifTrue: [
      i < args size ifTrue: [ examplePattern := args at: i + 1 ].
      ^true
    ].

    (arg startsWith: '--example=') ifTrue: [
      examplePattern := arg copyFrom: 11 to: arg size.
      ^true
    ].

    (arg = '-t' or: [arg = '--tag']) ifTrue: [
      i < args size ifTrue: [ tags add: (args at: i + 1) asSymbol ].
      ^true
    ].

    (arg startsWith: '--tag=') ifTrue: [
      tags add: (arg copyFrom: 7 to: arg size) asSymbol.
      ^true
    ].

    (arg = '-P' or: [arg = '--pattern']) ifTrue: [
      i < args size ifTrue: [ pattern := args at: i + 1 ].
      ^true
    ].

    (arg startsWith: '--pattern=') ifTrue: [
      pattern := arg copyFrom: 11 to: arg size.
      ^true
    ].

    (arg = '-p' or: [arg = '--profile']) ifTrue: [
      profileCount := 10. "default"
      "Check if next arg is a number"
      (i < args size and: [(args at: i + 1) first isDigit]) ifTrue: [
        profileCount := (args at: i + 1) asInteger.
      ].
      ^true
    ].

    (arg startsWith: '--profile=') ifTrue: [
      profileCount := (arg copyFrom: 11 to: arg size) asInteger.
      ^true
    ].

    (arg = '--dry-run') ifTrue: [
      dryRun := true.
      ^true
    ].

    (arg = '-v' or: [arg = '--version']) ifTrue: [
      showVersion := true.
      ^true
    ].

    (arg = '-h' or: [arg = '--help']) ifTrue: [
      showHelp := true.
      ^true
    ].

    (arg = '--no-color') ifTrue: [
      noColor := true.
      ^true
    ].

    "Check if starts with - (unknown option)"
    (arg startsWith: '-') ifTrue: [
      Transcript show: 'Unknown option: ', arg; cr.
      ^true
    ].

    ^false
  ]

  printVersion [
    Transcript show: 'ShellStone ', self class version; cr.
    ObjectMemory quit: 0.
  ]

  printHelp [
    Transcript show: 'Usage: shellstone [options] [files or directories]'; cr; cr.
    Transcript show: 'Options:'; cr.
    Transcript show: '  -f, --format FORMATTER   Output format (progress, documentation, html, json, failures)'; cr.
    Transcript show: '  -o, --out FILE           Output to file instead of stdout'; cr.
    Transcript show: '  --order TYPE[:SEED]      Run order (defined, random, random:SEED)'; cr.
    Transcript show: '  --seed SEED              Equivalent to --order random:SEED'; cr.
    Transcript show: '  --fail-fast              Abort on first failure'; cr.
    Transcript show: '  -e, --example STRING     Filter by description pattern'; cr.
    Transcript show: '  -t, --tag TAG            Filter by tag'; cr.
    Transcript show: '  -P, --pattern PATTERN    File pattern (default: **/*_spec.st)'; cr.
    Transcript show: '  -p, --profile [COUNT]    Show slowest examples (default: 10)'; cr.
    Transcript show: '  --dry-run                List examples without running'; cr.
    Transcript show: '  -v, --version            Show version'; cr.
    Transcript show: '  -h, --help               Show this help'; cr.
    Transcript show: '  --no-color               Disable colored output'; cr.
    ObjectMemory quit: 0.
  ]

  "Build formatter based on options"
  buildFormatter [
    format = 'progress' ifTrue: [ ^ProgressFormatter new ].
    format = 'documentation' ifTrue: [ ^DocumentationFormatter new ].
    format = 'doc' ifTrue: [ ^DocumentationFormatter new ].
    format = 'd' ifTrue: [ ^DocumentationFormatter new ].
    format = 'html' ifTrue: [ ^HtmlFormatter new ].
    format = 'json' ifTrue: [ ^JsonFormatter new ].
    format = 'failures' ifTrue: [ ^FailuresFormatter new ].
    ^ProgressFormatter new
  ]

  "Build ordering based on options"
  buildOrdering [
    seed notNil ifTrue: [
      ^Ordering randomWithSeed: seed
    ].
    ^Ordering parse: order
  ]

  "Build filter manager based on options"
  buildFilterManager [
    | filter |
    filter := FilterManager new.
    tags do: [:tag | filter addTag: tag].
    examplePattern notNil ifTrue: [
      filter addPattern: examplePattern.
    ].
    ^filter
  ]

  "Build profiler based on options"
  buildProfiler [
    profileCount notNil ifTrue: [
      ^Profiler enabled: profileCount
    ].
    ^Profiler new
  ]
]

]
