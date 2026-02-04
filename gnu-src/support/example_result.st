"Result tracking for examples (passed/failed/pending)"

Namespace current: ShellStone [

Object subclass: ExampleResult [
  | example status exception startTime endTime |

  ExampleResult class >> passed: anExample [
    ^self new
      example: anExample;
      status: #passed;
      yourself
  ]

  ExampleResult class >> failed: anExample exception: anException [
    ^self new
      example: anExample;
      status: #failed;
      exception: anException;
      yourself
  ]

  ExampleResult class >> pending: anExample [
    ^self new
      example: anExample;
      status: #pending;
      yourself
  ]

  ExampleResult class >> new [
    ^super new initialize
  ]

  initialize [
    status := #pending.
  ]

  example [ ^example ]
  example: anExample [ example := anExample ]
  status [ ^status ]
  status: aSymbol [ status := aSymbol ]
  exception [ ^exception ]
  exception: anException [ exception := anException ]
  startTime [ ^startTime ]
  startTime: aTime [ startTime := aTime ]
  endTime [ ^endTime ]
  endTime: aTime [ endTime := aTime ]

  passed [ ^status = #passed ]
  failed [ ^status = #failed ]
  pending [ ^status = #pending ]

  duration [
    (startTime isNil or: [endTime isNil]) ifTrue: [ ^0 ].
    ^endTime - startTime
  ]

  failureMessage [
    exception isNil ifTrue: [ ^'' ].
    ^exception messageText
  ]

  fullDescription [
    ^example fullDescription
  ]

  location [
    ^example location
  ]
]

]
