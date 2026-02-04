"Custom exception for expectation failures"

Namespace current: ShellStone [

Error subclass: ExpectationFailed [
  | expected actual matcher |

  ExpectationFailed class >> expected: expectedValue actual: actualValue matcher: aMatcher [
    ^(self new)
      expected: expectedValue;
      actual: actualValue;
      matcher: aMatcher;
      yourself
  ]

  expected [ ^expected ]
  expected: aValue [ expected := aValue ]
  actual [ ^actual ]
  actual: aValue [ actual := aValue ]
  matcher [ ^matcher ]
  matcher: aMatcher [ matcher := aMatcher ]

  description [
    ^'ExpectationFailed'
  ]

  messageText [
    matcher isNil ifTrue: [ ^super messageText ].
    ^matcher failureMessage
  ]
]

]
