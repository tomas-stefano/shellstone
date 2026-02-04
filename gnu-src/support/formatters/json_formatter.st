"JSON formatter - JSON output"

Namespace current: ShellStone [

BaseFormatter subclass: JsonFormatter [
  | results startTime |

  initialize [
    super initialize.
    results := OrderedCollection new.
  ]

  started [
    startTime := Time millisecondClockValue.
  ]

  examplePassed: aResult [
    results add: aResult.
  ]

  exampleFailed: aResult [
    results add: aResult.
  ]

  examplePending: aResult [
    results add: aResult.
  ]

  finished: allResults [
    | elapsed passedCount failedCount pendingCount json |
    elapsed := (Time millisecondClockValue - startTime) / 1000.0.
    passedCount := allResults count: [:r | r passed].
    failedCount := allResults count: [:r | r failed].
    pendingCount := allResults count: [:r | r pending].

    json := WriteStream on: String new.
    json nextPutAll: '{'; cr.
    json nextPutAll: '  "version": "1.0",'; cr.
    json nextPutAll: '  "seed": null,'; cr.
    json nextPutAll: '  "summary": {'; cr.
    json nextPutAll: '    "duration": ', elapsed printString, ','; cr.
    json nextPutAll: '    "example_count": ', allResults size printString, ','; cr.
    json nextPutAll: '    "failure_count": ', failedCount printString, ','; cr.
    json nextPutAll: '    "pending_count": ', pendingCount printString; cr.
    json nextPutAll: '  },'; cr.
    json nextPutAll: '  "examples": ['; cr.

    allResults doWithIndex: [:result :index |
      json nextPutAll: '    {'; cr.
      json nextPutAll: '      "description": "', (self escapeJson: result fullDescription), '",'; cr.
      json nextPutAll: '      "status": "', result status asString, '"'.
      result failed ifTrue: [
        json nextPutAll: ','; cr.
        json nextPutAll: '      "exception": {'; cr.
        json nextPutAll: '        "message": "', (self escapeJson: result failureMessage), '"'; cr.
        json nextPutAll: '      }'.
      ].
      result location isEmpty ifFalse: [
        json nextPutAll: ','; cr.
        json nextPutAll: '      "file_path": "', (self escapeJson: result location), '"'.
      ].
      json cr.
      json nextPutAll: '    }'.
      index < allResults size ifTrue: [ json nextPutAll: ',' ].
      json cr.
    ].

    json nextPutAll: '  ]'; cr.
    json nextPutAll: '}'.

    self print: json contents.
  ]

  escapeJson: aString [
    ^aString asString
      copyReplaceAll: '\' with: '\\';
      copyReplaceAll: '"' with: '\"';
      copyReplaceAll: (String with: Character cr) with: '\n';
      copyReplaceAll: (String with: Character lf) with: '\n';
      copyReplaceAll: (String with: Character tab) with: '\t'
  ]
]

]
