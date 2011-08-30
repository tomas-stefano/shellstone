Object subclass: Describe [
  <category: 'Core'>
  <comment: 'Class responsible to dispatching the examples to ExampleGroup class.'>
  
  Describe class >> the: aClass do: aBlock [
    (ExampleGroup describe: aClass block: aBlock) register.
  ]
]