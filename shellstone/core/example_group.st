Object subclass: ExampleGroup [
  <category: 'Core'>
  <comment: 'Class responsible to register the example group specs.'>
  |example_groups described example_group_block|
  example_groups := Set new.
  
  ExampleGroup class >> describe: aClass block: aBlock [
    |example_group_instance|
    example_group_instance := self basicNew initialize: aClass block: aBlock.
    self examples add: example_group_instance.
    ^example_group_instance
  ]
  
  ExampleGroup class >> examples [
    ^example_groups
  ]
  
  initialize: aClass block: aBlock [
    described := aClass.
    example_group_block := aBlock.
    example_group_block receiver: self.
    ^self
  ]
  
  register [
    ^example_group_block value: self
  ]
  
  it: aString do: aBlock [
    aBlock value
  ]
]