"Test doubles"

Namespace current: ShellStone [

Object subclass: Double [
  | name stubs messageExpectations receivedMessages |

  Double class >> new [
    ^super new initialize
  ]

  Double class >> named: aString [
    ^self new name: aString; yourself
  ]

  initialize [
    name := 'double'.
    stubs := Dictionary new.
    messageExpectations := OrderedCollection new.
    receivedMessages := OrderedCollection new.
  ]

  name [ ^name ]
  name: aString [ name := aString ]
  stubs [ ^stubs ]
  messageExpectations [ ^messageExpectations ]
  receivedMessages [ ^receivedMessages ]

  "Stubbing"
  stub: aSelector [
    ^MethodStub new
      double: self;
      selector: aSelector;
      yourself
  ]

  stub: aSelector andReturn: aValue [
    | stub |
    stub := self stub: aSelector.
    stub returnValue: aValue.
    stubs at: aSelector put: stub.
    ^stub
  ]

  stub: aSelector andDo: aBlock [
    | stub |
    stub := self stub: aSelector.
    stub block: aBlock.
    stubs at: aSelector put: stub.
    ^stub
  ]

  stub: aSelector andRaise: anException [
    | stub |
    stub := self stub: aSelector.
    stub exception: anException.
    stubs at: aSelector put: stub.
    ^stub
  ]

  "Message expectations"
  shouldReceive: aSelector [
    | expectation |
    expectation := MessageExpectation new
      double: self;
      selector: aSelector;
      yourself.
    messageExpectations add: expectation.
    ^expectation
  ]

  shouldReceive: aSelector withArgs: anArray [
    | expectation |
    expectation := self shouldReceive: aSelector.
    expectation expectedArgs: anArray.
    ^expectation
  ]

  "Handle messages"
  doesNotUnderstand: aMessage [
    | selector args stub |
    selector := aMessage selector.
    args := aMessage arguments.

    "Record the message"
    receivedMessages add: (Array with: selector with: args).

    "Check for stub"
    stub := stubs at: selector ifAbsent: [nil].
    stub notNil ifTrue: [
      ^stub valueWithArgs: args
    ].

    "Check for expectation with return value"
    messageExpectations do: [:exp |
      (exp selector = selector) ifTrue: [
        exp recordCall: args.
        exp returnValue notNil ifTrue: [ ^exp returnValue ].
      ].
    ].

    "No stub found, return nil by default"
    ^nil
  ]

  "Verification"
  verify [
    messageExpectations do: [:exp |
      exp verify.
    ].
  ]

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

  reset [
    stubs := Dictionary new.
    messageExpectations := OrderedCollection new.
    receivedMessages := OrderedCollection new.
  ]

  printOn: aStream [
    aStream nextPutAll: '#<Double:', name, '>'.
  ]
]

]
