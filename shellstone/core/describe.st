Object subclass: Describe [
  <category: 'Core'>
  <comment: 'Class responsible to describing the behavior of any class'>
  |described_class described_block|
  
  Describe class >> the: aClass do: aBlock [
    (ExampleGroup describe: aClass block: aBlock) register.
  ]
]