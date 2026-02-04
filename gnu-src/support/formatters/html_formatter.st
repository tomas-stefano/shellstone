"HTML formatter - HTML report output"

Namespace current: ShellStone [

BaseFormatter subclass: HtmlFormatter [
  | failures pendingExamples startTime buffer |

  initialize [
    super initialize.
    failures := OrderedCollection new.
    pendingExamples := OrderedCollection new.
    buffer := WriteStream on: String new.
  ]

  started [
    startTime := Time millisecondClockValue.
    buffer nextPutAll: '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ShellStone Test Results</title>
  <style>
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 2em; }
  .passed { color: #22863a; }
  .failed { color: #cb2431; }
  .pending { color: #b08800; }
  .example { margin: 0.5em 0; padding-left: 1em; }
  .group { margin: 1em 0; }
  .group-title { font-weight: bold; }
  .failure { background: #ffeef0; padding: 1em; margin: 1em 0; border-left: 3px solid #cb2431; }
  .failure-message { color: #cb2431; }
  .location { color: #6a737d; font-size: 0.9em; }
  .summary { margin-top: 2em; padding: 1em; border-top: 1px solid #e1e4e8; }
  </style>
</head>
<body>
<h1>ShellStone Test Results</h1>
<div class="results">
'.
  ]

  groupStarted: aGroup [
    buffer nextPutAll: '<div class="group">'.
    buffer nextPutAll: '<div class="group-title">', (self escape: aGroup description), '</div>'.
  ]

  groupFinished: aGroup [
    buffer nextPutAll: '</div>'.
  ]

  examplePassed: aResult [
    buffer nextPutAll: '<div class="example passed">&#x2714; ', (self escape: aResult example description), '</div>'.
  ]

  exampleFailed: aResult [
    failures add: aResult.
    buffer nextPutAll: '<div class="example failed">&#x2718; ', (self escape: aResult example description), '</div>'.
  ]

  examplePending: aResult [
    pendingExamples add: aResult.
    buffer nextPutAll: '<div class="example pending">&#x25CB; ', (self escape: aResult example description), ' (PENDING)</div>'.
  ]

  finished: results [
    | elapsed passedCount failedCount pendingCount summaryClass |
    buffer nextPutAll: '</div>'.

    "Print failures"
    failures isEmpty ifFalse: [
      buffer nextPutAll: '<h2>Failures</h2>'.
      failures doWithIndex: [:result :index |
        buffer nextPutAll: '<div class="failure">'.
        buffer nextPutAll: '<strong>', index printString, ') ', (self escape: result fullDescription), '</strong><br>'.
        buffer nextPutAll: '<span class="failure-message">', (self escape: result failureMessage), '</span><br>'.
        result location isEmpty ifFalse: [
          buffer nextPutAll: '<span class="location"># ', (self escape: result location), '</span>'.
        ].
        buffer nextPutAll: '</div>'.
      ].
    ].

    "Calculate statistics"
    elapsed := (Time millisecondClockValue - startTime) / 1000.0.
    passedCount := results count: [:r | r passed].
    failedCount := results count: [:r | r failed].
    pendingCount := results count: [:r | r pending].

    summaryClass := failedCount > 0
      ifTrue: ['failed']
      ifFalse: [pendingCount > 0 ifTrue: ['pending'] ifFalse: ['passed']].

    buffer nextPutAll: '<div class="summary ', summaryClass, '">'.
    buffer nextPutAll: '<strong>Finished in ', elapsed printString, ' seconds</strong><br>'.
    buffer nextPutAll: results size printString, ' examples, ', failedCount printString, ' failures'.
    pendingCount > 0 ifTrue: [
      buffer nextPutAll: ', ', pendingCount printString, ' pending'.
    ].
    buffer nextPutAll: '</div>'.

    buffer nextPutAll: '</body></html>'.

    self print: buffer contents.
  ]

  escape: aString [
    ^aString asString
      copyReplaceAll: '&' with: '&amp;';
      copyReplaceAll: '<' with: '&lt;';
      copyReplaceAll: '>' with: '&gt;';
      copyReplaceAll: '"' with: '&quot;'
  ]
]

]
