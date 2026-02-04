"Entry point DSL for defining test suites"

Namespace current: ShellStone [

Object subclass: Describe [

  "Main entry point for describe blocks"
  Describe class >> the: aSubject do: aBlock [
    | group description |
    description := aSubject isString
      ifTrue: [ aSubject ]
      ifFalse: [ aSubject name ].
    group := ExampleGroup description: description.
    World instance register: group.
    aBlock value: group.
    ^group
  ]

  "With tags"
  Describe class >> the: aSubject tag: aTag do: aBlock [
    | group |
    group := self the: aSubject do: aBlock.
    group addTag: aTag.
    ^group
  ]

  Describe class >> the: aSubject tags: aTags do: aBlock [
    | group |
    group := self the: aSubject do: aBlock.
    group addTags: aTags.
    ^group
  ]

  "Convenience alias"
  Describe class >> describe: aSubject do: aBlock [
    ^self the: aSubject do: aBlock
  ]
]

]
