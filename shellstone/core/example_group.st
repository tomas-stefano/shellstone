"Example group (describe/context block)"

Namespace current: ShellStone [

Object subclass: ExampleGroup [
  | description examples childGroups parent hooks lets metadata |

  ExampleGroup class >> description: aString [
    ^self new description: aString; yourself
  ]

  ExampleGroup class >> description: aString parent: aGroup [
    ^self new
      description: aString;
      parent: aGroup;
      yourself
  ]

  ExampleGroup class >> new [
    ^super new initialize
  ]

  initialize [
    examples := OrderedCollection new.
    childGroups := OrderedCollection new.
    hooks := HookCollection new.
    lets := LetContainer new.
    metadata := Metadata new.
  ]

  description [ ^description ]
  description: aString [ description := aString ]
  examples [ ^examples ]
  childGroups [ ^childGroups ]
  parent [ ^parent ]
  parent: aGroup [ parent := aGroup ]
  hooks [ ^hooks ]
  lets [ ^lets ]
  metadata [ ^metadata ]
  metadata: aMetadata [ metadata := aMetadata ]

  "DSL methods"
  it: aDescription do: aBlock [
    | example |
    example := Example
      description: aDescription
      block: aBlock
      group: self.
    examples add: example.
    ^example
  ]

  it: aDescription [
    "Pending example (no block)"
    | example |
    example := Example pending: aDescription.
    example group: self.
    examples add: example.
    ^example
  ]

  it: aDescription tag: aTag do: aBlock [
    | example |
    example := self it: aDescription do: aBlock.
    example addTag: aTag.
    ^example
  ]

  it: aDescription tags: aTags do: aBlock [
    | example |
    example := self it: aDescription do: aBlock.
    example addTags: aTags.
    ^example
  ]

  context: aDescription do: aBlock [
    | childGroup |
    childGroup := ExampleGroup description: aDescription parent: self.
    childGroups add: childGroup.
    aBlock value: childGroup.
    ^childGroup
  ]

  describe: aDescription do: aBlock [
    "Alias for context"
    ^self context: aDescription do: aBlock
  ]

  before: aScope do: aBlock [
    hooks addBefore: aScope do: aBlock.
  ]

  after: aScope do: aBlock [
    hooks addAfter: aScope do: aBlock.
  ]

  let: aName do: aBlock [
    lets define: aName as: aBlock.
  ]

  "Access let values using dynamic method handling"
  doesNotUnderstand: aMessage [
    | selector |
    selector := aMessage selector.
    (lets has: selector) ifTrue: [
      ^lets get: selector
    ].
    parent isNil ifFalse: [
      ^parent doesNotUnderstand: aMessage
    ].
    ^super doesNotUnderstand: aMessage
  ]

  "Hierarchy helpers"
  descriptionParts [
    | parts |
    parts := OrderedCollection new.
    parent isNil ifFalse: [
      parts addAll: parent descriptionParts.
    ].
    parts add: description.
    ^parts
  ]

  fullDescription [
    | parts result |
    parts := self descriptionParts.
    result := WriteStream on: String new.
    parts doWithIndex: [:part :idx |
      idx > 1 ifTrue: [ result nextPut: Character space ].
      result nextPutAll: part.
    ].
    ^result contents
  ]

  depth [
    parent isNil ifTrue: [ ^0 ].
    ^parent depth + 1
  ]

  "Collect all examples including from child groups"
  allExamples [
    | all |
    all := OrderedCollection new.
    all addAll: examples.
    childGroups do: [:child |
      all addAll: child allExamples.
    ].
    ^all
  ]

  "Get merged hooks from parent chain"
  effectiveHooks [
    parent isNil ifTrue: [ ^hooks ].
    ^hooks merge: parent effectiveHooks
  ]

  "Get merged lets from parent chain"
  effectiveLets [
    | merged |
    merged := LetContainer new.
    parent isNil ifFalse: [
      merged merge: parent effectiveLets.
    ].
    merged merge: lets.
    ^merged
  ]

  "Add tags"
  addTag: aSymbol [
    metadata addTag: aSymbol.
  ]

  addTags: aCollection [
    metadata addTags: aCollection.
  ]

  hasTag: aSymbol [
    ^metadata hasTag: aSymbol
  ]

  "Run all examples in this group"
  run [
    | results effectiveHooks effectiveLets |
    results := OrderedCollection new.
    effectiveHooks := self effectiveHooks.
    effectiveLets := self effectiveLets.

    effectiveHooks runBeforeAll.
    [
      examples do: [:example |
        results add: (example runWithHooks: effectiveHooks lets: effectiveLets).
      ].
      childGroups do: [:child |
        results addAll: child run.
      ].
    ] ensure: [
      effectiveHooks runAfterAll.
    ].
    ^results
  ]
]

]
