"Failures formatter - file:line:reason format for editor integration"

Namespace current: ShellStone [

BaseFormatter subclass: FailuresFormatter [
  | failures |

  initialize [
    super initialize.
    failures := OrderedCollection new.
  ]

  examplePassed: aResult [
    "No output for passed examples"
  ]

  exampleFailed: aResult [
    failures add: aResult.
  ]

  examplePending: aResult [
    "No output for pending examples"
  ]

  finished: results [
    failures do: [:result |
      | location message |
      location := result location isEmpty
        ifTrue: ['unknown']
        ifFalse: [result location].
      message := result failureMessage copyReplaceAll: (String with: Character cr) with: ' '.
      message := message copyReplaceAll: (String with: Character lf) with: ' '.
      self printLn: location, ': ', message.
    ].
  ]
]

]
