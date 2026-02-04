"Spy - wraps real object and records calls"

Namespace current: ShellStone [

Object subclass: Spy [
  | target receivedMessages |

  Spy class >> new [
    ^super new initialize
  ]

  Spy class >> on: anObject [
    ^self new target: anObject; yourself
  ]

  initialize [
    receivedMessages := OrderedCollection new.
  ]

  target [ ^target ]
  target: anObject [ target := anObject ]
  receivedMessages [ ^receivedMessages ]

  "Forward messages to target and record them"
  doesNotUnderstand: aMessage [
    | selector args result |
    selector := aMessage selector.
    args := aMessage arguments.

    "Record the message"
    receivedMessages add: (Array with: selector with: args).

    "Forward to target"
    result := target perform: selector withArguments: args.
    ^result
  ]

  "Query received messages"
  received: aSelector [
    ^receivedMessages anySatisfy: [:msg | msg first = aSelector]
  ]

  received: aSelector times: aCount [
    | count |
    count := receivedMessages count: [:msg | msg first = aSelector].
    ^count = aCount
  ]

  received: aSelector withArgs: anArray [
    ^receivedMessages anySatisfy: [:msg |
      (msg first = aSelector) and: [msg second = anArray]
    ]
  ]

  callsTo: aSelector [
    ^receivedMessages select: [:msg | msg first = aSelector]
  ]

  argsForCallTo: aSelector [
    | call |
    call := receivedMessages detect: [:msg | msg first = aSelector] ifNone: [nil].
    call isNil ifTrue: [ ^nil ].
    ^call second
  ]

  reset [
    receivedMessages := OrderedCollection new.
  ]

  printOn: aStream [
    aStream nextPutAll: '#<Spy on: ', target printString, '>'.
  ]
]

]
