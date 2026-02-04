"Individual test case (it block)"

Namespace current: ShellStone [

Object subclass: Example [
  | description block group metadata pending pendingMessage |

  Example class >> description: aString block: aBlock [
    ^self new
      description: aString;
      block: aBlock;
      yourself
  ]

  Example class >> description: aString block: aBlock group: aGroup [
    ^self new
      description: aString;
      block: aBlock;
      group: aGroup;
      yourself
  ]

  Example class >> pending: aString [
    ^self new
      description: aString;
      pending: true;
      yourself
  ]

  Example class >> pending: aString message: aMessage [
    ^self new
      description: aString;
      pending: true;
      pendingMessage: aMessage;
      yourself
  ]

  Example class >> new [
    ^super new initialize
  ]

  initialize [
    metadata := Metadata new.
    pending := false.
  ]

  description [ ^description ]
  description: aString [ description := aString ]
  block [ ^block ]
  block: aBlock [ block := aBlock ]
  group [ ^group ]
  group: aGroup [ group := aGroup ]
  metadata [ ^metadata ]
  metadata: aMetadata [ metadata := aMetadata ]
  pending [ ^pending ]
  pending: aBoolean [ pending := aBoolean ]
  pendingMessage [ ^pendingMessage ]
  pendingMessage: aString [ pendingMessage := aString ]

  isPending [ ^pending or: [block isNil] ]

  fullDescription [
    "Build full description from group hierarchy"
    | parts result |
    parts := OrderedCollection new.
    group isNil ifFalse: [
      parts addAll: group descriptionParts.
    ].
    parts add: description.
    result := WriteStream on: String new.
    parts doWithIndex: [:part :idx |
      idx > 1 ifTrue: [ result nextPut: Character space ].
      result nextPutAll: part.
    ].
    ^result contents
  ]

  location [
    ^metadata fullLocation
  ]

  addTag: aSymbol [
    metadata addTag: aSymbol.
  ]

  addTags: aCollection [
    metadata addTags: aCollection.
  ]

  hasTag: aSymbol [
    ^metadata hasTag: aSymbol
  ]

  run [
    "Execute the example"
    self isPending ifTrue: [
      ^ExampleResult pending: self
    ].
    ^[
      block value.
      ExampleResult passed: self
    ] on: ExpectationFailed do: [:ex |
      ExampleResult failed: self exception: ex
    ] on: PendingExample do: [:ex |
      ExampleResult pending: self
    ] on: Error do: [:ex |
      ExampleResult failed: self exception: ex
    ].
  ]

  runWithHooks: aHookCollection lets: aLetContainer [
    "Execute example with hooks and let bindings"
    | result |
    self isPending ifTrue: [
      ^ExampleResult pending: self
    ].
    result := nil.
    [
      aHookCollection runBeforeEach.
      result := [
        block value.
        ExampleResult passed: self
      ] on: ExpectationFailed do: [:ex |
        ExampleResult failed: self exception: ex
      ] on: PendingExample do: [:ex |
        ExampleResult pending: self
      ] on: Error do: [:ex |
        ExampleResult failed: self exception: ex
      ].
    ] ensure: [
      aLetContainer reset.
      aHookCollection runAfterEach.
    ].
    ^result
  ]
]

]
